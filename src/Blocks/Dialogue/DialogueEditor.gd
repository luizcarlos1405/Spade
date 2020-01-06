extends "res://PGEBase/PGEEditor/PGEEditor.gd"

onready var test_button: = $Header/Items/TestButton
onready var test_panel: = $TestPanel


func _ready():
	test_button.connect("pressed", self, "_on_TestButton_pressed")


func _on_TestButton_pressed() -> void:
	_graph.nodes = serialize()
	test_panel.graph = _graph
	test_panel.popup_centered()
