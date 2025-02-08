extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Points.points += 1
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
