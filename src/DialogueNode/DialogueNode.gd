tool
extends "res://PGEBase/PGENode/PGENode.gd"


func _ready():
	var blocks_data: = [
		{text = "Text", metadata = preload("res://src/Blocks/Text/TextBlock.tscn")},
		{text = "Option", metadata = preload("res://src/Blocks/Option/OptionBlock.tscn")},
		{text = "Conditional", metadata = preload("res://src/Blocks/Conditional/ConditionalBlock.tscn")},
		{text = "Expression", metadata = preload("res://src/Blocks/Expression/ExpressionBlock.tscn")},
		{text = "Skip", metadata = preload("res://src/Blocks/Skip/SkipBlock.tscn")},
		{text = "Jump", metadata = preload("res://src/Blocks/Jump/JumpBlock.tscn")},
	]

	set_block_options(blocks_data)