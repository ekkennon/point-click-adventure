extends Control

onready var Player = $player_sprite

func _input(event): 
	if Input.is_action_pressed("ui_leftMouseClick") and Player.state != PlayerData.INTERACT:
		Player.path = $Room0_Env/Navigation2D.get_simple_path(Player.get_global_position(), get_global_mouse_position())
		
		Player.is_going_to_interact = false 
		
		if Player.is_climbing:
			Player.change_state(PlayerData.CLIMB)
		else:
			Player.change_state(PlayerData.MOVE)


func _on_climbArea_body_entered(body):
	if body.get_name() == "PlayerBody":
		Player.is_climbing = true


func _on_climbArea_body_exited(body):
	if body.get_name() == "PlayerBody":
		Player.is_climbing = false

func _on_InteractionObjects_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("ui_leftMouseClick"):
		Player.is_going_to_interact = true
		Player.interactable_object = $InteractionObjects.get_child(shape_idx)
		Player.interaction_animation = $InteractionObjects.get_child(shape_idx).interaction_animation
		
		Player.path = $Room0_Env/Navigation2D.get_simple_path(Player.get_global_position(), $InteractionObjects.get_child(shape_idx).destination)
