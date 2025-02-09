extends Control

func _ready() -> void:
	$AnimationPlayer.play("Made")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("Credit")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("Out")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/menu_scene.tscn")
