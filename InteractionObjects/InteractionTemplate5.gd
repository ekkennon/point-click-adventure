extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var destination = get_node("Position2D").get_global_position()
export var interaction_animation : String 
var interaction_type = "simple"
export var RIGHT : bool


func interact():
	print("i am interacting")
	get_node("Sprite").get_node("AnimationPlayer").play("interact")	
