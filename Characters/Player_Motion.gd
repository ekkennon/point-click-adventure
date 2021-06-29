extends AnimatedSprite

export var speed = 250
var state = PlayerData.IDLE
var margin = 1
var destination = Vector2()
var velocity = Vector2()
var snapPosition = Vector2()
var path : PoolVector2Array
var is_climbing : bool
var is_going_to_interact : bool
var interactable_object 
var interaction_timer = 1
var interaction_animation: String


# Called when the node enters the scene tree for the first time.
func _ready():
	destination = position
	is_climbing = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_distance = speed * delta
	
	match state:
		PlayerData.MOVE:
			move_along_path(move_distance)
		PlayerData.CLIMB:
			climb_along_path(move_distance)
		PlayerData.INTERACT:
			interact(delta)

func move_along_path(distance):
	var starting_point: = position 
	
	if(is_climbing):
		change_state(PlayerData.CLIMB)
	
	if starting_point.x < path[0].x:
		set_flip_h(false)
	elif starting_point.x > path[0].x:
		set_flip_h(true)
	
	for i in range(path.size()):
		var distance_to_next: = starting_point.distance_to(path[0])
		
		if distance <= distance_to_next:
			position = starting_point.linear_interpolate(path[0], distance / distance_to_next) 
			break
		
		path.remove(0)
		
		if path.size() == 0:
			if is_going_to_interact:
				change_state(PlayerData.INTERACT)
			else:
				change_state(PlayerData.IDLE)


func climb_along_path(distance):
	var starting_point: = position 
	
	if starting_point.y > path[0].y:
		play("climb")
	elif starting_point.y < path[0].y:
		play("climb", true)
		
	if(!is_climbing):
		change_state(PlayerData.MOVE)
	
	for i in range(path.size()):
		var distance_to_next: = starting_point.distance_to(path[0])
		
		if distance <= distance_to_next:
			position = starting_point.linear_interpolate(path[0], distance / distance_to_next) 
			break
		
		path.remove(0)
		
		if path.size() == 0:
			change_state(PlayerData.IDLE)


func interact(delta):
	interaction_timer -= delta
	if interaction_timer <= 0:
		change_state(PlayerData.IDLE)
		interaction_timer = 1


func change_state(newState):
	state = newState
	match state: 
		PlayerData.IDLE:
			if(is_climbing):
				play("climb_idle")
			elif(!is_climbing):
				play("idle")
		PlayerData.MOVE:
			play("move")
		PlayerData.CLIMB:
			play("climb")
		PlayerData.INTERACT:
			interactable_object.interact()
			self.play(interaction_animation)
