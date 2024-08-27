extends RigidBody3D

func _physics_process(delta: float) -> void:
	# Apply a force along the players axis if a key is pressed
	apply_central_force(Input.get_axis("move_left", "move_right") * basis.x * 1200.0 * delta)
	apply_central_force(Input.get_axis("move_forward", "move_back") * basis.z * 1200.0 * delta)
