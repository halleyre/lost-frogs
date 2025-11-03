class_name LevelControls
extends AspectRatioContainer

@onready var ui_dpad = {
	Level.UP:    $VBoxContainer/Up,
	Level.RIGHT: $HBoxContainer/Right,
	Level.DOWN:  $VBoxContainer/Down,
	Level.LEFT:  $HBoxContainer/Left}
const key_dpad = {
	Level.UP:    "ui_up",
	Level.RIGHT: "ui_right",
	Level.DOWN:  "ui_down",
	Level.LEFT:  "ui_left"}

signal move_just_pressed(direction)
signal move_released(direction)
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

# is there a better way to stop the controls from falling off the screen?
func restore_controls():
	var canvas_scale = get_canvas_transform().get_scale()
	position = get_viewport_rect().end / canvas_scale - size

func toggle_pan():
	pan_mode = !pan_mode
	$VBoxContainer/Move.visible = !$VBoxContainer/Move.visible
	$HBoxContainer/Pan.visible = !$HBoxContainer/Pan.visible

func _input(event: InputEvent):
	for dir in key_dpad:
		if event.is_action_pressed(key_dpad[dir]):
			(pan_just_pressed if pan_mode else move_just_pressed).emit(dir)
		if event.is_action_released(key_dpad[dir]):
			(pan_released if pan_mode else move_released).emit(dir)
	
	if event.is_action_pressed(pan_mode_action): toggle_pan()
	
	for dir in focus_actions:
		if event.is_action_pressed(focus_actions[dir]):
			focus.emit(dir)
			break # avoid triggering `tab` as part of `shift+tab`

func _on_nav(source):
	for dir in ui_dpad:
		if source == ui_dpad[dir]:
			(pan_just_pressed if pan_mode else move_just_pressed).emit(dir)

func _on_nav_release(source):
	for dir in ui_dpad:
		if source == ui_dpad[dir]:
			(pan_released if pan_mode else move_released).emit(dir)
