extends CharacterBody3D

const SPEED = 4.0

# Initialize player variables
var player = null
@export var player_path: NodePath

# Get navigation agent
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	player = get_node(player_path)
	
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	# Navigation
	navigation_agent_3d.set_target_position(player.global_transform.origin)
	var next_position = navigation_agent_3d.get_next_path_position()
	velocity = (next_position - global_transform.origin)
	move_and_slide()
