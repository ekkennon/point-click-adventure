extends Control

enum{IDLE, MOVE, CLIMB, INTERACT}

onready var nav2D : Navigation2D = $Navigation2D
onready var line2D : Line2D = $Line2D
onready var Player : AnimatedSprite = $Player
onready var InteractionObjects : Area2D = $InteractionObjects
onready var InfoCard : Control = $UI.get_node("InfoCard")

func _input(event): 
	if !Input.is_action_pressed("ui_leftMouseClick"):
		return
	if (Player.state == INTERACT):
		return

	var new_path = nav2D.get_simple_path(Player.get_global_position(), get_global_mouse_position())
	
	#line2D.points = new_path 
	
	Player.path = new_path
	
	Player.is_going_to_interact = false 
	
	if(!Player.is_climbing):
		Player.change_state(MOVE)
	else:
		Player.change_state(CLIMB)

func _on_ClimbArea_body_entered(body):
	if body.get_name() != "PlayerBody":
		return
	Player.is_climbing = true
	pass # Replace with function body.


func _on_ClimbArea_body_exited(body):
	if body.get_name() != "PlayerBody":
		return
	Player.is_climbing = false
	pass # Replace with function body.


func _on_InteractionObjects_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("ui_leftMouseClick"):
		return
	
	Player.is_going_to_interact = true
	Player.interactable_object = InteractionObjects.get_child(shape_idx)
	Player.interaction_animation = InteractionObjects.get_child(shape_idx).interaction_animation 
	Player.interaction_direction = InteractionObjects.get_child(shape_idx).RIGHT
	
	var interaction_type = InteractionObjects.get_child(shape_idx).interaction_type
	
	match interaction_type:
		"info":
			InteractionObjects.get_child(shape_idx).InfoCard = InfoCard
			InfoCard.Text.bbcode_text = InteractionObjects.get_child(shape_idx).text
			InfoCard.rect_position = InteractionObjects.get_child(shape_idx).info_card_position.get_global_transform_with_canvas().origin
	
	var new_path = nav2D.get_simple_path(Player.get_global_position(), InteractionObjects.get_child(shape_idx).destination)
	Player.path = new_path


func _on_InfoCard_close_dialog():
	Player.change_state(IDLE)
	
