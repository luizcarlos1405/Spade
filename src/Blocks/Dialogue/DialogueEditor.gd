extends "res://PGEBase/PGEEditor/PGEEditor.gd"

onready var test_button: = $Header/Items/TestButton
onready var test_panel: = $TestPanel
onready var start_node: = $ScrollContainer/Panel/Nodes/Start

func _ready():
	test_button.connect("pressed", self, "_on_TestButton_pressed")

	start_node.connect("tree_exited", self, "_on_graph_node_tree_exited", [start_node])
	start_node.connect("moved", self, "_on_graph_node_moved", [start_node])
	start_node.connect("released", self, "_on_graph_node_released", [start_node])


func _on_TestButton_pressed() -> void:
	_graph.nodes = serialize()
	test_panel.graph = _graph
	test_panel.popup_centered()