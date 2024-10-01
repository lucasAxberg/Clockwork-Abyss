extends ProgressBar

const player = preload("res://Scripts/character_body_3d.gd")

var parent = player
var max_value_amount
var min_value_amount

func _ready() -> void:
	parent = get_parent()
	#max_value_amount = parent.health_max
	#min_value_amount = parent.health_min

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#if parent.health != max_value_amount:
	#	self.visible = true
	#	if parent.health == min_value_amount:
	#		self.visible = false
	#		
	#else:
	#	self.visible = false
