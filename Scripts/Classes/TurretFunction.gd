class_name Turret_Functions


func get_closest_enemy(vision_area: Area3D, vision_raycast: RayCast3D) -> Node3D:
	var overlaps = vision_area.get_overlapping_bodies()
	
	# Exit if no overlaps exist
	if overlaps.size() <= 0:
		return null
	
	# Initialize variables for closest node
	var closest_node: Node3D
	var closest_node_distance: float
	
	for overlap in overlaps:
		
		# Look at enemies and force raycast update
		if overlap.is_in_group("enemy"):
			var enemy_position = overlap.global_position
			vision_raycast.look_at(enemy_position)
			vision_raycast.force_raycast_update()
			
			# Check if raycast collides with a collider that is in enemy group
			if vision_raycast.is_colliding():
				var collider = vision_raycast.get_collider()
				if collider.is_in_group("enemy"):
					
					# Check if new collider is closer than the previous one and update variables if nessecary
					var distance: float = vision_raycast.global_position.distance_to(collider.global_position)
					if distance > closest_node_distance:
						closest_node_distance = distance
						closest_node = collider
	
	return closest_node
