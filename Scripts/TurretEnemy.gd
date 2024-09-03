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
	if global_position.distance_to(player.global_position) >= player_distance_threshold:
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
		if global_position.distance_to(turret.global_position) < global_position.distance_to(closest_turret.global_position):
			closest_turret = turret
	return closest_turret
