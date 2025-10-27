extends Node

@export var levels: Array[PackedScene]

var active_level: Level

func _ready():
	active_level = levels[0].instantiate()
	add_child(active_level)
	$UILayer.add_child(active_level.controls)
