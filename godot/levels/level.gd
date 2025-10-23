class_name Level
extends TileMapLayer

var controls: LevelControls = preload("res://ui/level_controls.tscn").instantiate()

var frogs
var active_frog
func _ready():
	controls.focus.connect(_on_focus)
	
	frogs = get_children().filter(func(node): return node is Frog)
	active_frog = frogs.find_custom(func(node): return node.has_node("Focus"))
	
	controls.move_just_pressed.connect(frogs[active_frog]._on_move_just_pressed)
	
func focus_new(new_frog):
	controls.move_just_pressed.disconnect(frogs[active_frog]._on_move_just_pressed)
	frogs[active_frog].get_node("Focus").reparent(frogs[new_frog], false)
	active_frog = new_frog
	controls.move_just_pressed.connect(frogs[active_frog]._on_move_just_pressed)

enum {PREV_F, NEXT_F}
func _on_focus(dir):
	if dir == PREV_F:
		focus_new(posmod(active_frog - 1, frogs.size()))
	if dir == NEXT_F:
		focus_new(posmod(active_frog + 1, frogs.size()))
