extends Node3D

var turret_functions = Turret.new()

var ammo = preload("res://Scenes/BalistaAmmo.tscn")

@onready var vision_area: Area3D = $VisionArea
@onready var vision_raycast: RayCast3D = $VisionRaycast

@onready var shoot_point: Node3D = $ShootPoint

@onready var attack_timer: Timer = $AttackTimer


var ammo_list = []
var direction_list = []
var speed = 10


func _process(delta: float) -> void:
	var closest_enemy: Node3D = turret_functions.get_closest_enemy(vision_area, vision_raycast)
	if closest_enemy:
		if attack_timer.get_time_left() == 0:
			ammo_list.append(ammo.instantiate())
			direction_list.append(shoot_point.global_position.direction_to(closest_enemy.global_position))
			add_child(ammo_list[-1])
			ammo_list[-1].global_position = shoot_point.global_position
			attack_timer.start()
		
	turret_functions.move_ammo(ammo_list, direction_list, speed * delta)
	#for a in range(ammo_list.size()):
		#ammo_list[a].global_position.x += direction_list[a].x * delta * speed
		#ammo_list[a].global_position.z += direction_list[a].z * delta * speed
		#var colliders = ammo_list[a].get_node("Area3D").get_overlapping_bodies()
		#if colliders.size() > 0:
			#print("colliding")
			#for collider in colliders:
				#if !collider.is_in_group("test"):
					#ammo_list[a].queue_free()
					#ammo_list.remove_at(a)
					#direction_list.remove_at(a)
