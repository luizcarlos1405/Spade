tool
extends "res://PGEBase/PGEBlock/PGEBlock.gd"


func get_data():
	return {text = $Parts/Content/TextEdit.text}
	pass


func set_data(data):
	$Parts/Content/TextEdit.text = data.text
	pass
