extends Node3D

@onready var vision_area: Area3D = $VisionArea


func _process(delta: float) -> void:
	var overlaps = vision_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.is_in_group("enemy"):
				# Code here
				pass
