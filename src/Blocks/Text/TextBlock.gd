tool
extends "res://PGEBase/PGEBlock/PGEBlock.gd"


var current_data: = {}


func _ready() -> void:
	current_data = {
		text = $Parts/Content/TextEdit.text
	}

	$Parts/Content/TextEdit.connect("focus_exited", self, "_on_LineEdit_focus_exited")


func _on_LineEdit_focus_exited() -> void:
	var new_data = {
		text = $Parts/Content/TextEdit.text
	}

	if current_data.text != new_data.text:
		PGE.undoredo_block_set_data(self, current_data, new_data)


func get_data() -> Dictionary:
	return current_data


func set_data(data: Dictionary):
	current_data = data
	$Parts/Content/TextEdit.text = current_data.text