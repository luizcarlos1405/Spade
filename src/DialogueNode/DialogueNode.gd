extends "res://PGEBase/PGENode/PGENode.gd"


func _ready():
	var blocks_data: = [
		{text = "Text", metadata = preload("res://src/Blocks/Text/TextBlock.tscn")},
		{text = "Option", metadata = preload("res://src/Blocks/Option/OptionBlock.tscn")},
		{text = "Expression", metadata = preload("res://src/Blocks/Expression/ExpressionBlock.tscn")},
		{text = "Skip", metadata = preload("res://src/Blocks/Skip/SkipBlock.tscn")},
	]

	set_block_options(blocks_data)