class_name Bullet

# Define movement related variables
var _position: Vector3
var _direction: Vector3
var _speed: int
var _bullet = null
var _piercing: int
# Variable to show if "_bullet" exists
var exists: bool

var colliders_id = []
var previous_pos: Vector3

func _init(pos: Vector3, dir: Vector3, speed: int, piercing: int, scene):
	# Assign inputed values to variables
	_bullet = scene.instantiate()
	_direction = dir
	_position = pos
	_speed = speed
	_piercing = piercing
	exists = true
	# Move bullet in <turret> scene to ShootingPoint's position
	_bullet.global_position = _position
	
func move_ammo(delta) -> void:
	# Save previous position
	previous_pos = _bullet.global_position
	# Move bullet according to speed and direction
	_bullet.global_position.x += _direction.x * _speed * delta
	_bullet.global_position.z += _direction.z * _speed * delta
	# Get all colliders the bullet touches
	#var colliders = _bullet.get_node("Area3D").get_overlapping_bodies()
	var colliders = get_passed_colliders() + _bullet.get_node("Area3D").get_overlapping_bodies()
	if colliders.size() > 0:
		for collider in colliders:
			if !collider.is_in_group("test"):
				# Check if bullet hasnt allready collided with the collider
				if !colliders_id.has(collider.get_instance_id()):
					if _piercing <= 0:
						# Remove bullet scene if bullet collides with a certain group and piercing = 0
						_bullet.queue_free()
						exists = false
						print("godbye")
					else:
						colliders_id.append(collider.get_instance_id())
						_piercing -= 1

func get_passed_colliders():
	# Get all children of _bullet instance and filter to get the RayCast3D
	var pass_raycast = _bullet.get_children().filter(func(item): return item.name == "PassCheck")[0]
	
	# Calculate the relative position to the previous position
	var raycast_pos = pass_raycast.global_position
	var relative_pos = previous_pos - raycast_pos
	
	# Update raycast target position
	pass_raycast.set_target_position(relative_pos)
	pass_raycast.force_raycast_update()
	
	# Get a list of all collisions
	var collision_array = []
	while pass_raycast.is_colliding():
		var closest_collider = pass_raycast.get_collider()
		collision_array.append(closest_collider)
		pass_raycast.add_exception(closest_collider)
		pass_raycast.force_raycast_update()
	
	# Remove exceptions
	pass_raycast.clear_exceptions()
	
	collision_array.reverse()
	
	return collision_array
