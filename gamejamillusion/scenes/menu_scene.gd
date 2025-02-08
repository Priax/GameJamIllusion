extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startPressed() -> void:
	get_tree().change_scene_to_file("res://menu_scene.tscn")
	

func optionPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_scene.tscn")

func exitPressed() -> void:
	get_tree().quit()
