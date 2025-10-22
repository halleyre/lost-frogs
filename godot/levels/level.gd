class_name Level
extends TileMapLayer

var controls: LevelControls = preload("res://ui/level_controls.tscn").instantiate()

var active_frog
func _ready():
	controls.focus.connect(_on_focus)
	
	active_frog = get_children().find_custom(
		func(node): return (
			node is Frog
			and node.has_node("Focus")))
	
	controls.move_just_pressed.connect(get_child(active_frog)._on_move_just_pressed)

enum {NEXT_F, PREV_F}
func _on_focus(dir):
	controls.move_just_pressed.disconnect(get_child(active_frog)._on_move_just_pressed)

	var new_frog = -1
	var old_frog = active_frog
	if dir == NEXT_F:
		while true:
			new_frog = get_children().find_custom(
				func(node): return node is Frog,
				old_frog + 1)
			if new_frog >= 0: break
			old_frog = -1

	if dir == PREV_F:
		while true:
			new_frog = get_children().rfind_custom(
				func(node): return node is Frog,
				old_frog)
			if new_frog >= 0: break
			old_frog = get_children().size()

	get_child(active_frog).get_node("Focus").reparent(get_child(new_frog), false)
	active_frog = new_frog
	controls.move_just_pressed.connect(get_child(active_frog)._on_move_just_pressed)
