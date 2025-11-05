class_name Frog
extends Area2D

# NB: keep this updated or dynamically set it
const TILE_SIZE = 32

var dead = false
var height = 0

var no_shift
var no_walk
func _ready():
	no_shift = get_node("NoShift")
	no_walk = get_node("NoWalk")

func raycast(dir_v, ray) -> bool:
	ray.global_rotation = dir_v.angle()
	ray.force_raycast_update()
	return ray.is_colliding()

# SHIFT: passive move
func shift(dir_v) -> bool:
	if raycast(dir_v, no_shift): return false
	
	
	position += dir_v * TILE_SIZE
	return true
	
# WALK: active move
func walk(dir_v) -> bool:
	if roundi(dir_v.dot(Vector2.from_angle(rotation))) == -1: return false
	if raycast(dir_v, no_walk): return false
	if !shift(dir_v): return false
	rotation = dir_v.angle()
	return true

func _on_move_just_pressed(dir):
	if dead: return
	
	var dir_v = Level.DIR_VECTORS[dir]
	walk(dir_v)
