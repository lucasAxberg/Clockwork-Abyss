class_name Bullet

# Define movement related variables
var _position: Vector3
var _direction: Vector3
var _speed: int
var _bullet = null
# Variable to show if "_bullet" exists
var exists: bool

func _init(pos: Vector3, dir: Vector3, speed: int, scene):
	# Assign inputed values to variables
	_bullet = scene.instantiate()
	_direction = dir
	_position = pos
	_speed = speed
	exists = true
	# Move bullet in <turret> scene to ShootingPoint's position
	_bullet.global_position = _position
	
func move_ammo(delta) -> void:
	# Move bullet according to speed and direction
	_bullet.global_position.x += _direction.x * _speed * delta
	_bullet.global_position.z += _direction.z * _speed * delta
	# Get all colliders the bullet touches
	var colliders = _bullet.get_node("Area3D").get_overlapping_bodies()
	if colliders.size() > 0:
		for collider in colliders:
			if !collider.is_in_group("test"):
				# Remove bullet scene if bullet collides with a certain group
				_bullet.queue_free()
				exists = false
