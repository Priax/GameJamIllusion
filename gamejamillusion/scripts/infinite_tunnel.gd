extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var player_sprite : AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var timer : Timer = $Timer
@onready var timerlabel : Label = $Player/Camera2D/TimerLabel

enum player_sprite_status {IDLE, RUN_LEFT, RUN_RIGHT, RUN_UP, RUN_DOWN}
var sprite_st : player_sprite_status = player_sprite_status.IDLE
var speed : float = 200
const SPAWN : Vector2 = Vector2(100, 0)
var ingame : bool = true

func _ready() -> void :
	player.position = SPAWN
	sprite_st = player_sprite_status.IDLE
	timer.timeout.connect(timer_faded_out)

func _process(delta : float) -> void :
	if ingame:
		update_player_position(delta)
		update_player_sprite()
		timerlabel.text = "TIMER : " + str(timer.time_left)

func timer_faded_out() -> void:
	ingame = false
	print("Timer faded out... game lost !")

func update_player_position(delta : float) -> void :
	var direction : Vector2 = Vector2.ZERO
	var idle : bool = true
	if Input.is_action_pressed("ui_left"):
		idle = false
		direction.x -= 1
		sprite_st = player_sprite_status.RUN_LEFT
	if Input.is_action_pressed("ui_right"):
		idle = false
		direction.x += 1
		sprite_st = player_sprite_status.RUN_RIGHT
	if Input.is_action_pressed("ui_up"):
		idle = false
		direction.y -= 1
		sprite_st = player_sprite_status.RUN_UP
	if Input.is_action_pressed("ui_down"):
		idle = false
		direction.y += 1
		sprite_st = player_sprite_status.RUN_DOWN
	if idle:
		sprite_st = player_sprite_status.IDLE
		return
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	move_player_with_collision(direction, delta)

func move_player_with_collision(direction : Vector2, delta : float) -> void :
	var velocity : Vector2 = direction * speed * delta
	var collision : KinematicCollision2D = player.move_and_collide(velocity)
	if collision:
		match collision.get_collider().name:
			"TP":
				var y : int = player.position.y
				player.position = SPAWN
				player.position.y = y
			"Portal":
				ingame = false
				print("Portal taken, game won !!!")
			_:
				if direction.x != 0:
					player.position.x -= velocity.x
				if direction.y != 0:
					player.position.y -= velocity.y

func update_player_sprite() -> void :
	var animation : String = ""
	match sprite_st:
		player_sprite_status.IDLE:
			animation = "idle"
		player_sprite_status.RUN_LEFT:
			animation = "run"
			player_sprite.flip_h = true
		player_sprite_status.RUN_RIGHT:
			animation = "run"
			player_sprite.flip_h = false
		player_sprite_status.RUN_UP:
			animation = "run"
		player_sprite_status.RUN_DOWN:
			animation = "run"
		_:
			return
	if player_sprite.is_playing() and player_sprite.animation == animation:
		return
	player_sprite.play(animation)
