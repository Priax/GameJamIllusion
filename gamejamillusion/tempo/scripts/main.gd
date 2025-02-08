extends Node2D

var points_game: Label


func _on_change_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
