extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var animation_player : AnimatedSprite2D = $Player/AnimationPlayer  # Use AnimatedSprite2D instead of AnimationPlayer

var speed : float = 100

func _ready() -> void:
	# Try forcing an animation change
	animation_player.animation = "idle"
	animation_player.play()

func _process(delta : float) -> void:
	update_player_position(delta)

# Met à jour la position du joueur
func update_player_position(delta : float):
	var direction : Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		move_player_with_collision(direction, delta)
		change_animation(direction)  # Change l'animation en fonction de la direction
	else:
		change_animation(Vector2.ZERO)  # Animation "idle" quand immobile

# Fonction pour déplacer le joueur et gérer les collisions
func move_player_with_collision(direction : Vector2, delta : float) -> void:
	var velocity : Vector2 = direction * speed * delta
	var collision : KinematicCollision2D = player.move_and_collide(velocity)
	if collision:
		if direction.x != 0:
			player.position.x -= velocity.x
		if direction.y != 0:
			player.position.y -= velocity.y

# Fonction pour changer l'animation en fonction de la direction
func change_animation(direction: Vector2) -> void:
	if animation_player == null:
		return

	var new_animation = "idle"
	if direction.y < 0:
		new_animation = "up"
	elif direction.y > 0:
		new_animation = "down"
	elif direction.x < 0:
		new_animation = "left"
	elif direction.x > 0:
		new_animation = "right"

	# Only change animation if it's different
	if animation_player.animation != new_animation:
		animation_player.animation = new_animation
		animation_player.play()
