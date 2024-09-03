extends CharacterBody3D

const SPEED = 4.0
const player_distance_threshold = 4.0

var player = null
var target = null

@export var player_path: NodePath
@export var target_path: NodePath


@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	player = get_node(player_path)
	target = get_node(target_path)
	
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	# Targeting player if they are too close, otherwise default target
	if get_path_length(player.global_position) >= player_distance_threshold:
		navigation_agent_3d.set_target_position(target.global_transform.origin)
	else:
		navigation_agent_3d.set_target_position(player.global_transform.origin)
	
	# Navigation
	var next_position = navigation_agent_3d.get_next_path_position()
	velocity = (next_position - global_transform.origin).normalized() * SPEED
	move_and_slide()


func get_path_length(location: Vector3) -> float:
	# Save previous target
	var previous_target_location = navigation_agent_3d.target_position
	
	# Set path and get distance to new loaction
	navigation_agent_3d.set_target_position(location)
	var length = navigation_agent_3d.distance_to_target()
	
	# Reset target location and return value
	navigation_agent_3d.set_target_position(previous_target_location)
	return length
