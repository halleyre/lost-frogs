class_name Level
extends TileMapLayer

var controls: LevelControls = preload("res://ui/level_controls.tscn").instantiate()

var active_frog: Frog
func _ready():
	active_frog = get_child(get_children().find_custom(func(node):
		return (node is Frog
				and node.get_children().any(func(n): return n is Camera2D))))
	
	controls.move_just_pressed.connect(active_frog._on_move_just_pressed)
