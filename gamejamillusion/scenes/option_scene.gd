extends Control

var sfx_bus = AudioServer.get_bus_index("SFX")
var master_bus = AudioServer.get_bus_index("Master")

func BackPresse() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_scene.tscn")

func checkFullScreen(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func changeValueMaster(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func changeValueSFX(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(sfx_bus, true)
	else:
		AudioServer.set_bus_mute(sfx_bus, false)

func soundPresse_aaaa() -> void:
	$Aaaaaaaa.play()

func soundPresseNoir() -> void:
	$"Allez-le-noir".play()
