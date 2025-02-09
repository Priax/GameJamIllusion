extends Node

@onready var timer: Timer = $"../Timer"

var points_game_final: Label
var hearts_list: Array[TextureRect]
var game_list: Array[String]

func exec_game() -> void :
	var index : int = randi() % game_list.size()
	var random_game : String = game_list[index]
	get_tree().change_scene_to_file(random_game)

func _ready():
	timer.timeout.connect(exec_game)
	load_games()
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

func load_games() -> void:
	var path : String = "res://scenes/"
	var dir : DirAccess = DirAccess.open(path)
	if dir == null:
		print("erreur dossier")
		return
	dir.list_dir_begin()
	var file_name : String = dir.get_next()
	while file_name != "":
		if file_name.begins_with("minigame_") and file_name.ends_with(".tscn"):
			game_list.append(path + file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
