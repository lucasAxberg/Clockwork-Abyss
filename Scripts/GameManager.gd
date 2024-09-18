extends Node

enum GameState {IDLE, RUNNING, ENDED}


@onready var ui = $ui as ui
@onready var game_manager = $"."
@onready var player = $Player

var points = 0
var game_state
var wait_time = 3

signal abyss_is_playing 

func points_scored():
	
	print(points)
	
	ui.update_points(points)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	
	ui._on_gamemanager_abyss_is_playing()
	#ui.connect("abyss_is_playing", self, "game_started")
	#pass
	#ui.game_started().connect(game_started)
	
func game_started():
	#emit_signal("abyss_is_playing")
	game_state = GameState.RUNNING
	ui.game_started().connect(game_started)
	
func on_game_end():
	ui.on_game_over()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		ui._on_escape_menu()
		#game_state = GameState.IDLE
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		
