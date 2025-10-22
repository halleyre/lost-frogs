class_name Frog
extends Sprite2D

enum {UP, RIGHT, DOWN, LEFT}
# order is important ^^vv
func dir_to_rot(dir) -> float:
	return dir * PI/2

func rot_to_dir(rot) -> int:
	rot = fposmod(rot, TAU)
	var dir = UP
	while rot > PI/4:
		rot -= PI/2
		dir += 1
	return dir % 4
	
func move_back():
	pass

func _on_move_just_pressed(dir):
	if posmod(dir - rot_to_dir(rotation), 4) == 2:
		move_back()
		return
	rotation = dir_to_rot(dir)
	
	match dir:
		UP:		position.y -= 32
		RIGHT:	position.x += 32
		DOWN:	position.y += 32
		LEFT:	position.x -= 32
