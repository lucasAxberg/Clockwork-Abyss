extends Node3D

@onready var vision_area: Area3D = $VisionArea
@onready var vision_raycast: RayCast3D = $VisionRaycast


func _process(delta: float) -> void:
	var overlaps = vision_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		
		for overlap in overlaps:
			if overlap.is_in_group("enemy"):
				var enemy_position = overlap.global_position
				vision_raycast.look_at(enemy_position)
				vision_raycast.force_raycast_update()
				
				if vision_raycast.is_colliding():
					var collider = vision_raycast.get_collider()
					if collider.is_in_group("enemy"):
						vision_raycast.debug_shape_custom_color = Color(255, 0, 0)
						print("I see you")
					else:
						vision_raycast.debug_shape_custom_color = Color(0, 255, 0)
						print("I don't see you")
						
						
