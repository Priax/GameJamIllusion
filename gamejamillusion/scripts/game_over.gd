extends Node

@onready var timer: Timer = $"../Timer"
@onready var win_sound: AudioStreamPlayer2D = $"../win_sound"
@onready var loose_sound: AudioStreamPlayer2D = $"../loose_sound"

var points_game_final: Label
var hearts_list: Array[TextureRect]
var game_list: Array[String] = [
	"res://scenes/minigame_audio.tscn",
	"res://scenes/minigame_infini.tscn",
	"res://scenes/minigame_invisible.tscn"
]

func exec_game() -> void :
	if game_list.size() == 0:
		print("pa2jeu noob")
		return
	var index : int = randi() % game_list.size()
	var random_game : String = game_list[index]
	get_tree().change_scene_to_file(random_game)

func _ready():
	timer.timeout.connect(exec_game)
	# Afficher le score
	points_game_final = %FinalScore
	var points = Points.points
	points_game_final.text = "Votre score: " + str(points) + "."
	
	# Afficher les vies
	var hearts_parent = $"../Health_bar/HBoxContainer"
	for child in hearts_parent.get_children():
		hearts_list.append(child)

	# Si le joueur a perdu, lui faire perdre une vie
	if not Points.is_win:
		take_damage()
		loose_sound.play()
	else:
		win_sound.play()
	update_heart_display()

func take_damage():
	if Points.health > 0:
		Points.health -= 1
	Points.is_win = true
	if Points.health == 0:
		get_tree().quit()

func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < Points.health

func _on_button_pressed() -> void:
	take_damage()
	print(Points.health)
