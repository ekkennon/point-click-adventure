extends AnimatedSprite


export var speed = 250

var path : PoolVector2Array
var interaction_timer = 1  # try using a real timer from Dodge The Creeps example
var interact_dir : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.is_climbing = false
	PlayerData.state = PlayerData.IDLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_distance = speed * delta
	
	match PlayerData.state:
		PlayerData.MOVE:
			move_along_path(move_distance)
		PlayerData.CLIMB:
			climb_along_path(move_distance)
		PlayerData.INTERACT:
			interact(delta)


func move_along_path(distance):
	var starting_point: = position 
	
	if(PlayerData.is_climbing):
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
			if PlayerData.is_going_to_interact:
				change_state(PlayerData.INTERACT)
			else:
				change_state(PlayerData.IDLE)


func climb_along_path(distance):
	var starting_point: = position 
	
	if starting_point.y > path[0].y:
		play("climb")
	elif starting_point.y < PlayerData.path[0].y:
		play("climb", true)
		
	if(!PlayerData.is_climbing):
		change_state(PlayerData.MOVE)
	
	for i in range(PlayerData.path.size()):
		var distance_to_next: = starting_point.distance_to(PlayerData.path[0])
		
		if distance <= distance_to_next:
			position = starting_point.linear_interpolate(PlayerData.path[0], distance / distance_to_next) 
			break
		
		PlayerData.path.remove(0)
		
		if PlayerData.path.size() == 0:
			change_state(PlayerData.IDLE)


func interact(delta):
	if PlayerData.interaction_animation != "interact_info_down" and PlayerData.interaction_animation != "interact_info_up":
		interaction_timer -= delta
		if interaction_timer <= 0:
			change_state(PlayerData.IDLE)
			interaction_timer = 1


func change_state(newState):
	PlayerData.state = newState
	match PlayerData.state: 
		PlayerData.IDLE:
			if PlayerData.is_climbing:
				play("climb_idle")
			elif !PlayerData.is_climbing:
				play("idle")
		PlayerData.MOVE:
			play("move")
		PlayerData.CLIMB:
			play("climb")
		PlayerData.INTERACT:
			PlayerData.interactable_object.interact()
			play(PlayerData.interaction_animation)


func face_dir(RIGHT):
	if RIGHT:
		set_flip_h(false)
	else:
		set_flip_h(true)
