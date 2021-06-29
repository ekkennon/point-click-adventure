extends Node


enum{IDLE, MOVE, CLIMB, INTERACT}

var state setget set_state, get_state
var is_climbing : bool setget set_is_climbing, get_is_climbing
var is_going_to_interact : bool setget set_is_going_to_interact, get_is_going_to_interact
var interaction_animation: String setget set_interaction_animation, get_interaction_animation
var interactable_object setget set_interactable_object, get_interactable_object


func set_state(value):
	state = value


func get_state():
	return state


func set_is_climbing(value):
	is_climbing = value


func get_is_climbing():
	return is_climbing


func set_is_going_to_interact(value):
	is_going_to_interact = value


func get_is_going_to_interact():
	return is_going_to_interact


func set_interaction_animation(value):
	interaction_animation = value


func get_interaction_animation():
	return interaction_animation


func set_interactable_object(value):
	interactable_object = value


func get_interactable_object():
	return interactable_object
