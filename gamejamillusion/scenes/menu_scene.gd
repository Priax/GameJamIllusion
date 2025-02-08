extends Control

func startPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_scene.tscn")

func optionPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_scene.tscn")

func exitPressed() -> void:
	get_tree().quit()
