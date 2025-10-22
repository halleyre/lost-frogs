class_name LevelControls
extends Node2D

signal move_just_pressed(direction)
signal move_released(direction)
const dir_actions = {
	Frog.UP: 	"ui_up",
	Frog.RIGHT: "ui_right",
	Frog.DOWN:	"ui_down",
	Frog.LEFT:	"ui_left"}

signal pan(direction)
signal focus(dir)

func _input(event: InputEvent):
	for dir in dir_actions:
		if event.is_action_pressed(dir_actions[dir]):
			move_just_pressed.emit(dir)
		if event.is_action_released(dir_actions[dir]):
			move_released.emit(dir)
