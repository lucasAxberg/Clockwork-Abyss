extends CharacterBody3D

@export var speed: float = 300.0
var gravity = 9.82

func _physics_process(delta: float) -> void:
	# Apply a force along the players axis if a key is pressed
	var new_v = Vector3.ZERO
	
	var direction_x = Input.get_axis("move_left", "move_right") * basis.x * speed * delta
	var direction_z = Input.get_axis("move_forward", "move_back") * basis.z * speed * delta
	
	var tot = direction_x + direction_z
	
	new_v.x = tot.x
	new_v.z = tot.z
	new_v.y = velocity.y - gravity * delta
		
	velocity = Vector3.ZERO
	velocity = new_v
	
	move_and_slide()
