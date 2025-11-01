class_name Frog
extends Sprite2D

var map: TileMapLayer
var pos_i: Vector2i

func invalid_move():
	pass
	
func move_back():
	invalid_move()

func _on_move_just_pressed(dir):
	if roundi(Level.DIR_VECTORS[dir].dot(Vector2.from_angle(rotation))) == -1:
		move_back()
		return

	rotation = Level.DIR_VECTORS[dir].angle()
	position += Level.DIR_VECTORS[dir] * 32
	
	
	
	
