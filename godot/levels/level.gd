class_name Level
extends TileMapLayer

enum {UP, RIGHT, DOWN, LEFT}
const DIR_VECTORS = {
	UP:    Vector2.UP,
	RIGHT: Vector2.RIGHT,
	DOWN:  Vector2.DOWN,
	LEFT:  Vector2.LEFT}

var controls: LevelControls = preload("res://ui/level_controls.tscn").instantiate()

var frogs
var active_frog
var camera
var active_pan = {}
	
@export var camera_speed = 200

func _ready():
	# start on frog with camera
	frogs = get_children().filter(func(node): return node is Frog)
	active_frog = frogs.find_custom(func(node): return node.has_node("Focus"))
	
	# init camera
	camera = frogs[active_frog].get_node("Focus")
	for dir in DIR_VECTORS:
		active_pan[dir] = false
	
	# connect frog signals
	controls.move_just_pressed.connect(frogs[active_frog]._on_move_just_pressed)
	
	# connect level signals
	controls.pan_just_pressed.connect(_on_pan_just_pressed)
	controls.pan_released.connect(_on_pan_released)
	controls.focus.connect(_on_focus)

func _process(delta):
	for dir in DIR_VECTORS:
		if active_pan[dir]:
			camera.position += delta * camera_speed * DIR_VECTORS[dir]
	
func _on_pan_just_pressed(dir):
	camera.reparent(self)
	active_pan[dir] = true
	
func _on_pan_released(dir):
	active_pan[dir] = false
	
func focus_new(new_frog):
	controls.move_just_pressed.disconnect(frogs[active_frog]._on_move_just_pressed)
	camera.position = Vector2.ZERO
	camera.reparent(frogs[new_frog], false)
	active_frog = new_frog
	controls.move_just_pressed.connect(frogs[active_frog]._on_move_just_pressed)

enum {PREV_F, NEXT_F}
func _on_focus(dir):
	if dir == PREV_F:
		focus_new(posmod(active_frog - 1, frogs.size()))
	if dir == NEXT_F:
		focus_new(posmod(active_frog + 1, frogs.size()))
