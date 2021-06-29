extends Node2D


export var low_index : int
export var high_index : int
export var y_threshold : float


func _process(delta):
	if get_parent().get_parent().player.position.y > y_threshold:
		set_z_index(low_index)
	else:
		set_z_index(high_index)
