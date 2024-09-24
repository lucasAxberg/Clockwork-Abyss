extends Node3D

var obj_enm = preload("res://Scenes/ObjectiveEnemy.tscn")
@onready var spawn_timer: Timer = $SpawnTimer
@onready var player: RigidBody3D = $"../../Player"
@onready var node_3d: Node3D = $"../../Node3D"


var classes = []

func _process(delta: float) -> void:
	if spawn_timer.get_time_left() < 0.1:
		spawn_timer.start(1)
		classes.append(Enemy.new(100, 4.0, node_3d, player, obj_enm))
		add_child(classes[-1].scene_instance)
		classes[-1].scene_instance.global_position = global_position
		print(classes.size())
		
	for enemy in classes:
		enemy.move()
	
	classes = classes.filter(func(item): return item.health > 0)
	
