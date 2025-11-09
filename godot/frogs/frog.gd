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

func raycast(dir_v, ray) -> Object:
	ray.global_rotation = dir_v.angle()
	ray.force_raycast_update()
	return ray.get_collider()

# SHIFT: passive move
func shift(dir_v) -> bool:
	var obstruction = raycast(dir_v, no_shift)
	if !resolve_shift(obstruction, dir_v): return false
	
	position += dir_v * tile_size
	var tile = map.get_cell_tile_data(map.local_to_map(position))
	no_shift.collision_mask &= ~Level.HEIGHT_MASK
	no_shift.set_collision_mask_value(tile.get_custom_data("exit_height"), true)
	
	return true

# WALK: active move
func walk(dir_v) -> bool:
	if roundi(dir_v.dot(Vector2.from_angle(rotation))) == -1: return false
	var obstruction = raycast(dir_v, no_walk)
	if !resolve_walk(obstruction, dir_v): return false
	if !shift(dir_v): return false
	rotation = dir_v.angle()
	return true

func resolve_shift(obstruction, dir_v) -> bool:
	if obstruction:
		if obstruction is Frog:
			if !obstruction.shift(dir_v): return false
		else: return false
	return true

func resolve_walk(obstruction, _dir_v) -> bool:
	if obstruction:
		return false
	return true

func _on_move_just_pressed(dir):
	if dead: return
	
	var dir_v = Level.DIR_VECTORS[dir]
	walk(dir_v)
