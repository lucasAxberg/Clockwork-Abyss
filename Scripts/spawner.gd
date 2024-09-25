extends Node3D
# Enemy scene
var objective_enemy = preload("res://Scenes/ObjectiveEnemy.tscn")

# Variables for nodes
@onready var spawn_timer: Timer = $SpawnTimer
@onready var player: RigidBody3D = $"../../Player"
@onready var node_3d: Node3D = $"../../Node3D"

# List to save class references
var classes = []

func _process(delta: float) -> void:
	if spawn_timer.get_time_left() < 0.1:
		# Restart timer
		spawn_timer.start(1)
		
		# Create and save reference to a new enemy and set it variables 
		classes.append(Enemy.new(100, 4.0, node_3d, player, objective_enemy))
		add_child(classes[-1].scene_instance)
		classes[-1].scene_instance.global_position = global_position
	
	# Move all enemies
	for enemy in classes:
		enemy.move()
	
	# Remove the enemies which has 0 health
	classes = classes.filter(func(item): return item.scene_instance.health > 0)
	
