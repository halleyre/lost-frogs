class_name Frog
extends Sprite2D

enum {LEFT, RIGHT, UP, DOWN}

func focus():
	UIEventbus.signals["move_just_pressed"].connect(_on_move_just_pressed)

func _on_move_just_pressed(dir):
	match dir:
		LEFT:
			position.x -= 32
		RIGHT:
			position.x += 32
		UP:
			position.y -= 32
		DOWN:
			position.y += 32
