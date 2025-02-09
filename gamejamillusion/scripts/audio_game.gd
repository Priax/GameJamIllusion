extends Node2D

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer : Timer = $AudioTimer
@onready var score_label : Label = $Score

var direction : Vector2 = Vector2(1, 0)
var speed : float = 1000
var score : int = 0

var MAX_LEFT : float = -1800
var MAX_RIGHT : float = 1800
var DISTANCE_THRESHOLD : float = 500
var N_SONG : int = 3

var sounds : Array[String] = []
var sound_count : int = 0
var game_over : bool = false
var win : bool = false

func _ready() -> void:
	load_sounds_from_directory("res://assets/audiogame/")
	setup_sound()

func _process(delta : float) -> void:
	if game_over:
		return
	update_sound_position(delta)
	update_player()
	update_score_display()

func update_player() -> void:
	if (Input.is_action_just_pressed("ui_select")) and !game_over:
		var distance : float = audio_player.position.distance_to(Vector2(0, 0))
		if distance <= DISTANCE_THRESHOLD:
			score += 100
			_next_sound()
		else:
			_end_game(false)

func setup_sound() -> void :
	timer.timeout.connect(_on_AudioTimer_timeout)
	timer.start()
	_next_sound()

func update_sound_position(delta : float) -> void :
	$test.position = audio_player.position
	audio_player.position += direction * speed * delta
	if audio_player.position.x > MAX_RIGHT:
		direction = Vector2(-1, 0)
	elif audio_player.position.x < MAX_LEFT:
		direction = Vector2(1, 0)

func _on_AudioTimer_timeout() -> void :
	if !audio_player.playing:
		audio_player.play()

func update_score_display() -> void :
	score_label.text = "SCORE : " + str(score)

func _next_sound() -> void :
	if sound_count >= N_SONG:
		_end_game(true)
		return
	if sounds.size() == 0:
		print("pas2son mon con")
		return
	var index : int = randi() % sounds.size()
	var random_sound : String = sounds[index]
	sounds.pop_at(index)
	audio_player.stream = load(random_sound)
	audio_player.play()
	audio_player.position = Vector2(randi_range(MAX_LEFT, MAX_RIGHT), 0)
	direction = Vector2()
	if randi_range(0, 1) == 0:
		direction = Vector2(1, 0)
	else:
		direction = Vector2(-1, 0)
	sound_count += 1

func _end_game(win : bool) -> void :
	game_over = true
	print("status : " + str(win) + ", score: " + str(score))
	if win:
		Points.points += 1
	else:
		Points.is_win = false
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func load_sounds_from_directory(directory_path: String) -> void:
	var dir : DirAccess = DirAccess.open(directory_path)
	if dir == null:
		print("erreur dossier")
		return
	dir.list_dir_begin()
	var file_name : String = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".mp3"):
			sounds.append(directory_path + file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
