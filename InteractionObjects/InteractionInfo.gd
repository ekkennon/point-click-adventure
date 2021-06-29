extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var destination = get_node("Position2D").get_global_position()
onready var info_card_position : Position2D = $CardPosition2D2
export var interaction_animation : String 
var interaction_type = "info"
export var text = "A pile of wooden boxes and barrels. A fallen barrel reveals a compilation of fur."
export var RIGHT : bool
var InfoCard


func interact():
	print("i am interacting")
	
	InfoCard.toogle(true)
