extends Node2D


export var low_index : int
export var high_index : int
export var y_threshold : float
export var interaction_animation : String
export var RIGHT : bool

onready var destination = $Position2D.get_global_position()

var interaction_type = "simple"


func _process(delta):
	if get_parent().get_parent().get_parent().player.position.y > y_threshold:
		set_z_index(low_index)
	else:
		set_z_index(high_index)


func interact():
	$Sprite/AnimationPlayer.play("interact")
