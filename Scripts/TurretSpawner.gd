extends Node3D

var projectile_script = preload("res://Scripts/Variables/ProjectileTurret.gd")
var area_script = null

var turret = null


var turret_dictionary = {
	"ballista": {
		"damage" : 100.0,
		"speed": 75.0,
		"ammo_count" : 10,
		"piercing" : 5,
		"attack_time" : 3.0,
		"projectile" : preload("res://Scenes/BalistaAmmo.tscn"),
		"turret" : preload("res://Scenes/Ballista.tscn"),
		"script" : projectile_script,
	},
}

func spawn_turret(turret_name: String, condition):
	var chosen_turret = turret_dictionary[turret_name]
	turret = chosen_turret["turret"].instantiate()
	add_child(turret)
	turret.set_script(chosen_turret["script"])
	turret.global_position = global_position
	
	if chosen_turret.has("projectile"):
		turret.set_vars(
			chosen_turret["ammo_count"],
			chosen_turret["speed"],
			chosen_turret["piercing"],
			chosen_turret["damage"],
			chosen_turret["projectile"],
			chosen_turret["attack_time"],
			condition,
		)
	
func _ready():
	spawn_turret("ballista", 100.0)

func _process(delta: float) -> void:
	turret.attack(delta)
