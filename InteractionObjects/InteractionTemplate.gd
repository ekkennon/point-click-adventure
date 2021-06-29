extends Node


export var interaction_animation : String
export var RIGHT : bool
onready var destination = $Position2D.get_global_position()
var interaction_type = "simple"


func interact():
	$Sprite/AnimationPlayer.play("interact")
