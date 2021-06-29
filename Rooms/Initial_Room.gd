extends Control


onready var player = $player_sprite
onready var info_card : Control = $UI/InfoCard


func _input(event): 
	if Input.is_action_pressed("ui_leftMouseClick") and PlayerData.state != PlayerData.INTERACT:
		player.path = $Room0_Env/Navigation2D.get_simple_path(player.get_global_position(), get_global_mouse_position())
		
		PlayerData.is_going_to_interact = false 
		
		if PlayerData.is_climbing:
			player.change_state(PlayerData.CLIMB)
		else:
			player.change_state(PlayerData.MOVE)


func _on_climbArea_body_entered(body):
	if body.get_name() == "PlayerBody":
		PlayerData.is_climbing = true


func _on_climbArea_body_exited(body):
	if body.get_name() == "PlayerBody":
		PlayerData.is_climbing = false


func _on_InteractionObjects_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("ui_leftMouseClick"):
		PlayerData.is_going_to_interact = true
		PlayerData.interactable_object = $Room0_Env/InteractionObjects.get_child(shape_idx)
		PlayerData.interaction_animation = $Room0_Env/InteractionObjects.get_child(shape_idx).interaction_animation
		#player.interac_dir = $Room0_Env/InteractionObjects.get_child(shape_idx).RIGHT
		
		var interaction_type = $Room0_Env/InteractionObjects.get_child(shape_idx).interaction_type
		match interaction_type:
			"info":
				$Room0_Env/InteractionObjects.get_child(shape_idx).info_card = info_card
				info_card.text_label.bbcode_text = $Room0_Env/InteractionObjects.get_child(shape_idx).text
				info_card.rect_position = $Room0_Env/InteractionObjects.get_child(shape_idx).info_card_position.get_global_transform_with_canvas().origin
		
		player.path = $Room0_Env/Navigation2D.get_simple_path(player.get_global_position(), $Room0_Env/InteractionObjects.get_child(shape_idx).destination)


func _on_InfoCard_close_dialog():
	player.change_state(PlayerData.IDLE)
