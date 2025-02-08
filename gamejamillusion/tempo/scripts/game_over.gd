extends Node

var points_game_final: Label
var health = Points.health
var hearts_list: Array[TextureRect]

func _ready():
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

func take_damage():
	if health > 0:
		health -= 1
	Points.is_win = true
	update_heart_display()
	if health == 0:
		get_tree().quit()

func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health


func _on_button_pressed() -> void:
	take_damage()
	print(health)
