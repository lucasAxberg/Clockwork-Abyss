class_name HurtBox
extends Area3D


signal recived_damage(damage: int)

# get health and export (some way idk how) 
@onready var Hitbox = preload("res://Hitbox.gd")

func _ready() -> void:
	connect("area_entered", _on_hurtablebox_area_entered)

#@onready var health_bar: ProgressBar = $durring_game_screen/HealthBar
@onready var collision_shape_3d_2: CollisionShape3D = $CollisionShape3D2

const health_bar = preload("res://Scenes/health_bar.gd")

func _on_hurtablebox_area_entered(hitbox: Hitbox) -> void:
	if hitbox.get_parent().has_method("get_damage_amount"):
		pass
		#var node = area.get_parent() as Node
		#health_bar -= node.damage_amount
		#print("health amount:", health_bar)
	


#func _on_hurtablebox_area_entered(hitbox: Hitbox) -> void:
	#print("hurtbox area entered!!!")
	#if Hitbox != null:
	#	health_bar -= Hitbox.get_damage_amountw
	#	recived_damage.emit(hitbox.damage)
	#	print("DAMAGE WAS TAKEN")
