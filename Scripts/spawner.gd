extends Node3D
# Enemy scene
var objective_enemy = preload("res://Scenes/ObjectiveEnemy.tscn")

var scr = preload("res://Scripts/Variables/Enemy.gd")

# Variables for nodes
@onready var spawn_timer: Timer = $SpawnTimer
@onready var player: CharacterBody3D = $"../../../Player"
@onready var node_3d: Node3D = $"../../../Target"

var Enemies = []

func _process(delta: float) -> void:
	if spawn_timer.get_time_left() < 0.1:
		# Restart timer
		spawn_timer.start()
		
		# Create and save reference to a new enemy and set it variables 
		Enemies.append(objective_enemy.instantiate())
		add_child(Enemies[-1])
		Enemies[-1].set_script(scr)
		Enemies[-1].global_position = global_position
		Enemies[-1].set_vars(100.0, 4.0, node_3d, player)
	
	# Move all enemies
	for enemy in Enemies:
		enemy.move()
		if enemy.health <= 0:
			enemy.queue_free()
	
	# Remove the enemies which has 0 health
	Enemies = Enemies.filter(func(item): return item.health > 0)
	
