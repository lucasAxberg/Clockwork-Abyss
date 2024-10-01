class_name Hitbox

extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D 
@onready var invull_timer: Timer = $InvullTimer

@export var invul_time : float = 0.0

#@export var damage: int = 20: set = set_damage, get = get_damage 

var damage_amount : int = 20

signal on_hit

func _ready() -> void:
	pass
	#on_hit.connect(on_area_hit)
	
func apply_hit() -> void:
	collision_shape_3d.set_deferred("disabled",true)
	invull_timer.start(invul_time)
	
#func on_area_hit():
	#apply_hit()
	#emit_signal()
	#print("HIT")
	#invull_timer.timeout.connect(in_invul_timer_timeout)
	
func in_invul_timer_timeout() -> void:
	collision_shape_3d.disabled = false

func set_damage(value: int):
	pass
	#damage = value
	
	
#func get_damage() -> int:
#	pass
	
	#return damage


func _on_area_entered(area: Area3D) -> void:
	print("you stept into damage")

func get_damage_amount() -> int:
	return damage_amount

func _on_body_entered(body: Node3D) -> void:
	print("body entered into damage")
	
	
