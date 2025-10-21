extends Node2D

signal move_just_pressed(direction)
signal move_released(direction)
signal pan(direction)
const dir_actions = ["ui_left", "ui_right", "ui_up", "ui_down"]

signal focus(dir)

func _enter_tree():
	UIEventbus.signals["move_just_pressed"] = move_just_pressed
	UIEventbus.signals["move_released"] = move_released
	
func _exit_tree():
	UIEventbus.signals.erase("move_just_pressed")
	UIEventbus.signals.erase("move_released")

func _process(_delta):
	for dir in range(dir_actions.size()):
		if Input.is_action_just_pressed(dir_actions[dir]):
			move_just_pressed.emit(dir)
		if Input.is_action_just_released(dir_actions[dir]):
			move_released.emit(dir)
