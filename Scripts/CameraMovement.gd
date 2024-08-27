extends Camera3D

# Set rotation speed and initialize rotation values
@export var mouse_sensitivity: float = 0.001
@export var max_rotation_angle: int = 180
var twist_input := 0.0
var pitch_input := 0.0

# Acess the nodes that will be rotated
@onready var pitch_pivot: Node3D = $".."      # 'HeadPoint' node
@onready var player: RigidBody3D = $"../.."   # 'Player' node


func _ready() -> void:
	# Hide and intercept mouse when game is started
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta: float) -> void:
	# Make mouse visible when ESC is pressed (PLACEHOLDER)
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Rotate the player along the y-axis and the "head" along the x-axis
	player.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	
	# Clamp rotation to prevent upside-down camera
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
	-deg_to_rad(max_rotation_angle/2), 
	deg_to_rad(max_rotation_angle/2)
	)
	
	# Reset rotation values so the camera stops spinning
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	# Asign twist- and pitch-input when mouse is captured and hidden 
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:			
			
			# Use negative values so camera moves up when mouse does
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			
