class_name Level
extends TileMapLayer

func _ready():
	get_child(
		get_children().find_custom(func(node): return node is Frog)
	).focus()
