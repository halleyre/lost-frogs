class_name LevelControls
extends Node2D

signal move_just_pressed(direction)
signal move_released(direction)
const move_actions = {
	Frog.UP: 	"ui_up",
	Frog.RIGHT: "ui_right",
	Frog.DOWN:	"ui_down",
	Frog.LEFT:	"ui_left"}

signal pan(direction)
signal focus(dir)
const focus_actions = { # order is important here as ui-prev contains ui-next
	Level.PREV_F: "ui_focus_prev",
	Level.NEXT_F: "ui_focus_next"}


func _input(event: InputEvent):
	for dir in move_actions:
		if event.is_action_pressed(move_actions[dir]):
			move_just_pressed.emit(dir)
		if event.is_action_released(move_actions[dir]):
			move_released.emit(dir)

	for dir in focus_actions:
		if event.is_action_pressed(focus_actions[dir]):
			focus.emit(dir)
			break
