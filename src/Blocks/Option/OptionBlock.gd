tool
extends "res://PGEBase/PGEBlock/PGEBlock.gd"


func get_data():
	return {text = $Parts/Content/LineEdit.text}


func set_data(data):
	$Parts/Content/LineEdit.text = data.text
