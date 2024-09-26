extends CharacterBody3D

# Speed variable
var health: float
var max_speed: float
var target_ref: Node3D
var player_ref: Node3D
var nav_agent: NavigationAgent3D


func set_vars(h: float, speed: float, target: Node3D, player: Node3D):
	
	# Set variables
	max_speed = speed
	target_ref = target
	player_ref = player
	health = h
	nav_agent = get_children().filter(func(item): return item.name == "NavigationAgent3D")[0]
	
	# Get navigaion agent and set target
	nav_agent.set_target_position(target_ref.global_position)

func move():
	# If dead, remove enemy visually and stop funtion
	if health <= 0:
		return
	
	# Set velocity of enemy to 0
	velocity = Vector3.ZERO
	
	# If target is the player, constantly update path to player
	if player_ref == target_ref:
		nav_agent.set_target_position(target_ref.global_transform.origin)
	
	# Get next position and set velocity to max_speed in that angle
	var next_position = nav_agent.get_next_path_position()
	velocity = (next_position - global_transform.origin).normalized() * max_speed
	move_and_slide()
