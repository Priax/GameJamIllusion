extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	# Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	Points.is_win = false


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
