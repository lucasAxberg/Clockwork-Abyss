extends Node3D

# Instance variables
var turret_functions = Turret_Functions.new()
var projectile_script = preload("res://Scripts/Variables/Bullet.gd")

# Node references
var vision_area: Area3D
var vision_raycast: RayCast3D
var shoot_point: Node3D
var attack_timer: Timer

# Turret variables
var condition: float
var ammo_count: int
var attack_time: float

# Projectile variables
var speed: float
var piercing: int
var damage:float

# List of references to all bullets
var bullet_list = []
var projectile = null

func set_vars(ammo: int, spd: float, prc: int, dmg: float, prj_scn, atk_time:float, cnd: float = 100.0):
	condition = cnd
	ammo_count = ammo
	speed = spd
	piercing = prc
	damage = dmg
	projectile = prj_scn
	attack_time = atk_time
	
	vision_area = get_node("VisionArea")
	vision_raycast = get_node("VisionRaycast")
	shoot_point = get_node("ShootPoint")
	attack_timer = get_node("AttackTimer")

func attack(delta: float) -> void:
	var closest_enemy: Node3D = turret_functions.get_closest_enemy(vision_area, vision_raycast)
	if closest_enemy:
		
		# Only able to run if timer has run out previously
		if attack_timer.get_time_left() == 0:
		
			# Get position from ShootingPoint and direction from the closest enemy
			var direction = shoot_point.global_position.direction_to(closest_enemy.global_position)
			var pos = shoot_point.position
		
			# Add new instance of bullet class to bullet_list
			bullet_list.append(projectile.instantiate())
			bullet_list[-1].set_script(projectile_script)
			bullet_list[-1].set_vars(pos, direction, speed, piercing, damage)
			add_child(bullet_list[-1])
			attack_timer.start(attack_time)
			
	# Move all bullet scenes that exist
	for bullet in bullet_list:
		if bullet._piercing >= 0:
			bullet.move_ammo(delta)
		
	for bullet in bullet_list:
		if bullet._piercing < 0:
			bullet.queue_free()
		
	# Remove references to classes which doesn't contain bullet scene
	bullet_list = bullet_list.filter(func(item): return item._piercing >= 0)
	
