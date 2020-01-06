extends "res://PGEBase/PGEGraph.gd"
class_name Dialogue
"""
Represents a dialogue graph.
"""

var expression_base_instance = self
var state: = {}

func set(name, value) -> void:
	state[name] = value