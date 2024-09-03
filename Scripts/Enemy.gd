extends CharacterBody3D

const SPEED = 4.0


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
	
	# Navigation
	navigation_agent_3d.set_target_position(target.global_transform.origin)
	var next_position = navigation_agent_3d.get_next_path_position()
	velocity = (next_position - global_transform.origin).normalized() * SPEED
	move_and_slide()
