class_name Enemy

var health: float
var max_speed: float

var target: Node3D
var player: Node3D
const player_distance_threshold: float = 4.0
var nav_agent


var scene_instance = null

func _init(h: float, s: float, t: Node3D, p: Node3D, scene):
	health = h
	max_speed = s
	target = t
	player = p
	scene_instance = scene.instantiate()
	
	# Get navigaion agent
	nav_agent = scene_instance.get_children().filter(func(item): return item.name == "NavigationAgent3D")[0]
	nav_agent.set_target_position(target.global_position)

func move():
	scene_instance.velocity = Vector3.ZERO
	
	# Targeting player if they are too close, otherwise default target
	if player == target:
		nav_agent.set_target_position(target.global_transform.origin)
	#else:
		#nav_agent.set_target_position(player.global_transform.origin)
	
	# Navigation
	var next_position = nav_agent.get_next_path_position()
	scene_instance.velocity = (next_position - scene_instance.global_transform.origin).normalized() * max_speed
	scene_instance.move_and_slide()
