class_name Frog
extends Area2D

var dead = false

var map
var tile_size
var no_shift
var no_walk
func _ready():
	map = get_parent()
	tile_size = Vector2(map.tile_set.tile_size) * Level.TILE_DIV
	no_shift = get_node("NoShift")
	no_walk = get_node("NoWalk")

func raycast(dir_v, ray) -> bool:
	ray.global_rotation = dir_v.angle()
	ray.force_raycast_update()
	return ray.is_colliding()

# SHIFT: passive move
func shift(dir_v) -> bool:
	if raycast(dir_v, no_shift): return false
	position += dir_v * tile_size
	resolve_move()
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
	
func resolve_move():
	var tile = map.get_cell_tile_data(map.local_to_map(position))
	no_shift.collision_mask &= ~Level.HEIGHT_MASK
	no_shift.set_collision_mask_value(tile.get_custom_data("exit_height"), true)
