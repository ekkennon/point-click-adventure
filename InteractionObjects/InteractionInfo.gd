extends Node


onready var destination = $Position2D.get_global_position()
onready var info_card_position : Position2D = $CardPosition2D2

export var interaction_animation : String
export var text = "A pile of wooden boxes and barrels. A fallen barrel reveals a fur wrap."
export var RIGHT : bool

var interaction_type = "info"
var info_card  # this is set in Initial_Room > _on_InteractionObjects_input_event > match "info"


func interact():
	info_card.toggle(true)
