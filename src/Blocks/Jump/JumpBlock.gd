tool
extends "res://PGEBase/PGEBlock/PGEBlock.gd"


var current_data: = {}


func _ready() -> void:
	current_data = {
		node_name = $Parts/Content/LineEdit.text
	}

	$Parts/Content/LineEdit.connect("focus_exited", self, "_on_LineEdit_focus_exited")
	$Parts/Content/LineEdit.connect("text_entered", self, "_on_LineEdit_text_entered")


func _on_LineEdit_focus_exited() -> void:
	var new_data = {
		node_name = $Parts/Content/LineEdit.text
	}

	if current_data.node_name != new_data.node_name:
		PGE.undoredo_block_set_data(self, current_data, new_data)


func _on_LineEdit_text_entered(new_text: String) -> void:
	$Parts/Content/LineEdit.release_focus()


func get_data() -> Dictionary:
	return current_data


func set_data(data: Dictionary):
	current_data = data
	$Parts/Content/LineEdit.text = current_data.node_name