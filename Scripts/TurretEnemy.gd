extends CharacterBody3D

const SPEED = 4.0
const player_distance_threshold = 4.0

var player = null
var target_parent_node = null

@export var player_path: NodePath
@export var target_path: NodePath


@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	player = get_node(player_path)
	target_parent_node = get_node(target_path)
	
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	# Get the closest turret
	var target = get_closest_turret(target_parent_node)
	
	# Targeting player if they are too close, otherwise default target
	if get_path_length(player.global_position) >= player_distance_threshold:
		navigation_agent_3d.set_target_position(target.global_transform.origin)
	else:
		navigation_agent_3d.set_target_position(player.global_transform.origin)
	
	# Navigation
	var next_position = navigation_agent_3d.get_next_path_position()
	velocity = (next_position - global_transform.origin).normalized() * SPEED
	move_and_slide()


func get_closest_turret(turret_parent: Node3D) -> Node3D:
	var list_of_turrets = turret_parent.get_children()
	var closest_turret: Node3D = list_of_turrets[0]
	
	for turret in list_of_turrets:
		if get_path_length(turret.global_position) < get_path_length(closest_turret.global_position):
			closest_turret = turret
	return closest_turret


func get_path_length(location: Vector3) -> float:
	# Save previous target
	var previous_target_location = navigation_agent_3d.target_position
	
	# Set path and get distance to new loaction
	navigation_agent_3d.set_target_position(location)
	var length = navigation_agent_3d.distance_to_target()
	
	# Reset target location and return value
	navigation_agent_3d.set_target_position(previous_target_location)
	return length
