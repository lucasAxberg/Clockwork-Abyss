class_name Enemy

# Speed variable
var max_speed: float

# Targeting variables
var target_ref: Node3D
var player_ref: Node3D
var nav_agent

# Instance variables
var scene_instance = null
var variable_script = load("res://Scripts/Variables/EnemyHealth.gd")

func _init(health: float, speed: float, target: Node3D, player: Node3D, scene):
	# Instantiate enemy scene and add variable_script
	scene_instance = scene.instantiate()
	scene_instance.set_script(variable_script)
	
	# Set variables
	max_speed = speed
	target_ref = target
	player_ref = player
	scene_instance.health = health
	
	# Get navigaion agent and set target
	nav_agent = scene_instance.get_children().filter(func(item): return item.name == "NavigationAgent3D")[0]
	nav_agent.set_target_position(target_ref.global_position)

func move():
	# If dead, remove enemy visually and stop funtion
	if scene_instance.health <= 0:
		scene_instance.queue_free()
		return
	
	# Set velocity of enemy to 0
	scene_instance.velocity = Vector3.ZERO
	
	# If target is the player, constantly update path to player
	if player_ref == target_ref:
		nav_agent.set_target_position(target_ref.global_transform.origin)
	
	# Get next position and set velocity to max_speed in that angle
	var next_position = nav_agent.get_next_path_position()
	scene_instance.velocity = (next_position - scene_instance.global_transform.origin).normalized() * max_speed
	scene_instance.move_and_slide()
