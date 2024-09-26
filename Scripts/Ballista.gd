extends Node3D

# Instance variables
var turret_functions = Turret_Functions.new()
var ammo = preload("res://Scenes/BalistaAmmo.tscn")
var ammo_script = preload("res://Scripts/Variables/Bullet.gd")

# Node references
@onready var vision_area: Area3D = $VisionArea
@onready var vision_raycast: RayCast3D = $VisionRaycast
@onready var shoot_point: Node3D = $ShootPoint
@onready var attack_timer: Timer = $AttackTimer

# Bullet variables
var speed = 100
var piercing = 1
var damage = 75.0

# List of references to all bullets
var bullet_list = []

func _process(delta: float) -> void:
	var closest_enemy: Node3D = turret_functions.get_closest_enemy(vision_area, vision_raycast)
	if closest_enemy:
		
		# Only able to run if timer has run out previously
		if attack_timer.get_time_left() == 0:
		
			# Get position from ShootingPoint and direction from the closest enemy
			var direction = shoot_point.global_position.direction_to(closest_enemy.global_position)
			var pos = shoot_point.position
		
			# Add new instance of bullet class to bullet_list
			bullet_list.append(ammo.instantiate())
			bullet_list[-1].set_script(ammo_script)
			bullet_list[-1].set_vars(pos, direction, speed, piercing, damage)
			add_child(bullet_list[-1])
			attack_timer.start()
			
	# Move all bullet scenes that exist
	for bullet in bullet_list:
		if bullet._piercing >= 0:
			bullet.move_ammo(delta)
		
	for bullet in bullet_list:
		if bullet._piercing < 0:
			bullet.queue_free()
		
	# Remove references to classes which doesn't contain bullet scene
	bullet_list = bullet_list.filter(func(item): return item._piercing >= 0)
	
