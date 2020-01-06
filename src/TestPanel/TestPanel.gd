extends PopupPanel


onready var options_container: = $VBoxContainer/Options
onready var rich_text_label: = $VBoxContainer/RichTextLabel
onready var restart: = $VBoxContainer/Restart

var graph: Dialogue


func _ready() -> void:
	restart.connect("pressed", self, "open_graph")

	connect("about_to_show", self, "_on_about_to_show")


func _on_about_to_show() -> void:
	open_graph()
	pass


func open_graph() -> void:
	rich_text_label.text = ""
	go_to("Start")


func go_to(node_name: String) -> void:
	rich_text_label.text = ""
	for child in options_container.get_children():
		child.queue_free()

	graph.go_to(node_name)
	var blocks_by_type = graph.get_blocks_by_type()

	# Expression type
	var expressions: Array = blocks_by_type.get("Expression", [])
	handle_expressions(expressions)

	# Conditionals
	var conditionals: Array = blocks_by_type.get("Conditional", [])
	if not conditionals.empty():
		handle_conditional(conditionals[0])

	# Skip type
	var skips: Array = blocks_by_type.get("Skip", [])
	if not skips.empty():
		go_to(skips[0].connections[0])

	# Jump type
	var jumps: Array = blocks_by_type.get("Jump", [])
	if not jumps.empty():
		go_to(jumps[0].data)

	# Text type
	var texts: Array = blocks_by_type.get("Text", [])
	var state: GDScriptFunctionState = handle_texts(texts)
	if state:
		yield(state, "completed")

	# Option type
	var options: Array = blocks_by_type.get("Option", [])
	handle_options(options)


func handle_expressions(expressions: Array) -> void:
	for expression in expressions:
		var executor: = Expression.new()
		var err: = executor.parse(expression.data)
		if err:
			push_error("Failed parsing expression %s. Error %s: %s" %
				[expression.data, err, executor.get_error_text()])
			continue

		executor.execute([], graph)


func handle_conditional(conditional: Dictionary) -> void:
	var executor: = Expression.new()
	var err: = executor.parse(conditional.data)
	if err:
		push_error("Failed parsing expression %s. Error %s: %s" %
			[conditional.data, err, executor.get_error_text()])
		return

	var result: bool = executor.execute([], graph.expression_base_instance)
	if result:
		go_to(conditional.connections[0])
	else:
		go_to(conditional.connections[1])


func handle_texts(texts: Array) -> GDScriptFunctionState:
	var next_button: = Button.new()
	next_button.text = "Next"
	options_container.add_child(next_button)

	for i in texts.size():
		rich_text_label.text = texts[i].data.text.format(graph.state)

		if i < texts.size() - 1:
			yield(next_button, "pressed")

	next_button.queue_free()
	return null


func handle_options(options: Array) -> void:
	for option in options:
		var option_button: = Button.new()
		option_button.text = option.data.text

		options_container.add_child(option_button)

		option_button.connect("pressed", self, "go_to", [option.connections[0]])