extends Control

func startPressed() -> void:
	$"/root/MenuScene".hide()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func optionPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_scene.tscn")

func exitPressed() -> void:
	get_tree().quit()
