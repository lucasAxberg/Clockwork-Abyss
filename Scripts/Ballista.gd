extends Node3D

var turret_functions = Turret.new()

@onready var vision_area: Area3D = $VisionArea
@onready var vision_raycast: RayCast3D = $VisionRaycast


func _process(delta: float) -> void:
	var closest_enemy: Node3D = turret_functions.get_closest_enemy(vision_area, vision_raycast)
	print(closest_enemy.name)
	
