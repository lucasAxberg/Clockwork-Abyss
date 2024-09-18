extends CanvasLayer

class_name ui
#signal game_started
var game_points = 0
var seconds = 0

@onready var end_of_game_screen = $end_of_game_screen
@onready var durring_game_screen = $durring_game_screen
@onready var before_game_screen = $before_game_screen

@onready var settings_screen = $settings_screen
@onready var escape_screen = $escape_screen
@onready var lable = $durring_game_screen/count_up_time

var time = 0

func _process(delta):
	
	time += delta
		
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60) / 60
	var hr = fmod(fmod(time,3600 * 60) / 3600,24)
	#var dy = fmod(time,12960000) / 86400
	
	var time_passed = "%02dh : %02dmin : %02ds : %03d" % [hr,mins,secs,mils]
	lable.text = time_passed# + " : " + var2str(time)
	

func _ready():
	pass
	#$"..".connect("abyss_is_playing", self, "game_started")
	#$durring_game_screen/points.text = "%d" % 0
	
func update_points(points: int): #points func + ui
	game_points = points
	#$durring_game_screen/points.text = "%d" % points

func on_game_over(): #game over func + ui
	durring_game_screen.visible = false
	end_of_game_screen.visible = true
	$end_of_game_screen/end_game_scoreDisplay/points.text ="%d" % game_points
	

func _on_restart_button_pressed() -> void: #ui
	get_tree().reload_current_scene()


func _on_play_button_pressed() -> void: #ui
	get_tree().change_scene_to_file("res://Scenes/Main_Scene.tscn")
	#emit_signal("abyss_is_playing")
	#game_started()
	#game_started.emit()


func _on_gamemanager_abyss_is_playing() -> void: #gameplay + gameplay ui
	before_game_screen.visible = false
	durring_game_screen.visible = true


func _on_quit_button_pressed() -> void: #ui
	get_tree().quit()

func _on_settings_button_pressed() -> void: #ui
	settings_screen.visible = true
	#escape_screen.visible = false
	#before_game_screen.visible = false


func _on_exit_menu_button_pressed() -> void: #ui How tf do i make it unshow the right ui screen wtf
	if (escape_screen.visible == true):
		settings_screen.visible = false
	if (before_game_screen.visible == true):
		settings_screen.visible = false
		before_game_screen.visible = true
	else:
		pass

func _on_escape_menu() -> void:
	escape_screen.visible = true


func _on_resume_pressed() -> void:
	escape_screen.visible = false
	settings_screen.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
