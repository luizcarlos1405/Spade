tool
extends "res://PGEBase/PGENode/PGENode.gd"


func _ready():
	var blocks_data: = [
		{text = "Text", scene_path = "res://src/Blocks/Text/TextBlock.tscn"},
		{text = "Option", scene_path = "res://src/Blocks/Option/OptionBlock.tscn"},
		{text = "Conditional", scene_path = "res://src/Blocks/Conditional/ConditionalBlock.tscn"},
		{text = "Expression", scene_path = "res://src/Blocks/Expression/ExpressionBlock.tscn"},
		{text = "Skip", scene_path = "res://src/Blocks/Skip/SkipBlock.tscn"},
		{text = "Jump", scene_path = "res://src/Blocks/Jump/JumpBlock.tscn"},
	]

	set_block_options(blocks_data)