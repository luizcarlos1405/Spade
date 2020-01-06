extends PopupPanel


onready var grid_container: = $VBoxContainer/GridContainer
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
	for child in grid_container.get_children():
		child.queue_free()

	for node_name in graph.nodes:
		var node_option: = Button.new()
		node_option.text = node_name

		grid_container.add_child(node_option)

		node_option.connect("pressed", self, "go_to", [node_name])


func go_to(node_name: String) -> void:
	rich_text_label.text = ""
	for child in grid_container.get_children():
		child.queue_free()

	graph.go_to(node_name)
	var blocks_by_type = graph.get_blocks_by_type()

	# Expression type
	var expressions: Array = blocks_by_type.get("Expression", [])
	for expression in expressions:
		var executor: = Expression.new()
		var err: = executor.parse(expression.data)
		if err:
			push_error("Failed parsing expression %s. Error %s: %s" %
				[expression.data, err, executor.get_error_text()])
			continue

		executor.execute([], graph)

	# Skip type
	var skips: Array = blocks_by_type.get("Skip", [])
	if not skips.empty():
		go_to(skips[0].connections[0])

	# Text type
	var texts: Array = blocks_by_type.get("Text", [])
	for text in texts:
		rich_text_label.text = texts.pop_front().data.text.format(graph.state)
		while not texts.empty():
			var next_button: = Button.new()
			next_button.text = "Next"
			grid_container.add_child(next_button)

			yield(next_button, "pressed")

			next_button.queue_free()
			rich_text_label.text = texts.pop_front().data.text

	# Option type
	var options: Array = blocks_by_type.get("Option", [])
	for option in options:
		var option_button: = Button.new()
		option_button.text = option.data.text

		grid_container.add_child(option_button)

		option_button.connect("pressed", self, "go_to", [option.connections[0]])