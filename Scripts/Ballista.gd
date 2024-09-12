extends Node3D

var turret_functions = Turret.new()
var ammo = preload("res://Scenes/BalistaAmmo.tscn")

@onready var vision_area: Area3D = $VisionArea
@onready var vision_raycast: RayCast3D = $VisionRaycast
@onready var shoot_point: Node3D = $ShootPoint
@onready var attack_timer: Timer = $AttackTimer

var bullet_list = []
var speed = 10

func _process(delta: float) -> void:
	var closest_enemy: Node3D = turret_functions.get_closest_enemy(vision_area, vision_raycast)
	if closest_enemy:
		# Only able to run if timer has run out previously
		if attack_timer.get_time_left() == 0:
			# Get position from ShootingPoint and direction from the closest enemy
			var direction = shoot_point.global_position.direction_to(closest_enemy.global_position)
			var pos = shoot_point.position
			# Add new instance of bullet class to bullet_list
			bullet_list.append(Bullet.new(pos, direction, speed, ammo))
			# Add bullet scene to the ballista scene and restart timer
			add_child(bullet_list[-1]._bullet)
			attack_timer.start()
			
	# Move all bullet scenes that exist
	for bullet in bullet_list:
		if bullet.exists:
			bullet.move_ammo(delta)
			
	# Remove references to classes which doesn't contain bullet scene
	bullet_list = bullet_list.filter(func(item): return item.exists)
	
