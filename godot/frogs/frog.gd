class_name Frog
extends Area2D

func invalid_move():
	pass
	
func move_back():
	invalid_move()

func _on_move_just_pressed(dir):
	var dir_v = Level.DIR_VECTORS[dir]
	if roundi(dir_v.dot(Vector2.from_angle(rotation))) == -1:
		move_back()
		return

	rotation = dir_v.angle()
	position = transform * get_node("RayCast2D").target_position
	
	
	
	
