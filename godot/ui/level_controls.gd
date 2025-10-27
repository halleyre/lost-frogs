class_name LevelControls
extends AspectRatioContainer

signal move_just_pressed(direction)
signal move_released(direction)
const move_actions = {
	Frog.UP:    "ui_up",
	Frog.RIGHT: "ui_right",
	Frog.DOWN:  "ui_down",
	Frog.LEFT:  "ui_left"}
var move_buttons

signal pan_just_pressed(direction)
signal pan_released(direction)
var pan_mode = false
const pan_mode_action = "ui_select"

signal focus(dir)
const focus_actions = { # order is important here as ui-prev contains ui-next
	Level.PREV_F: "ui_focus_prev",
	Level.NEXT_F: "ui_focus_next"}

func _ready():
	get_viewport().size_changed.connect(restore_controls)
	restore_controls()
	move_buttons = {
		$VBoxContainer/Up:    Frog.UP,
		$HBoxContainer/Right: Frog.RIGHT,
		$VBoxContainer/Down:  Frog.DOWN,
		$HBoxContainer/Left:  Frog.LEFT}

	
# is there a better way to stop the controls from falling off the screen?
func restore_controls():
	var canvas_scale = get_canvas_transform().get_scale()
	position = get_viewport_rect().end / canvas_scale - size

func _input(event: InputEvent):
	for dir in move_actions:
		if event.is_action_pressed(move_actions[dir]):
			if pan_mode: pan_just_pressed.emit(dir)
			else:        move_just_pressed.emit(dir)
		if event.is_action_released(move_actions[dir]):
			if pan_mode: pan_released.emit(dir)
			else:        move_released.emit(dir)
	
	if event.is_action_pressed(pan_mode_action): toggle_pan()
	
	for dir in focus_actions:
		if event.is_action_pressed(focus_actions[dir]):
			focus.emit(dir)
			break

func toggle_pan():
	pan_mode = !pan_mode
	$VBoxContainer/Move.visible = !$VBoxContainer/Move.visible
	$HBoxContainer/Pan.visible = !$HBoxContainer/Pan.visible

func _on_nav(source):
	for btn in move_buttons:
		if source == btn:
			if pan_mode: pan_just_pressed.emit(move_buttons[btn])
			else:        move_just_pressed.emit(move_buttons[btn])

func _on_nav_release(source):
	for btn in move_buttons:
		if source == btn:
			if pan_mode: pan_released.emit(move_buttons[btn])
			else:        move_released.emit(move_buttons[btn])
