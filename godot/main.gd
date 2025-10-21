extends Node

@export var levels: Array[PackedScene]

var active_level

func _ready():
	$UILayer.add_child(load("res://ui/level_controls.tscn").instantiate())
	active_level = levels[0].instantiate()
	add_child(active_level)
