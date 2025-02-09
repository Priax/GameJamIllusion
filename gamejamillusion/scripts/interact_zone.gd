extends Area2D

@onready var interaction_label: Label = $Label
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
var player_nearby: bool = false

func _ready():
	if interaction_label == null:
		print("Erreur : Le Label n'a pas été trouvé!")
		return
	# Configuration explicite du Label
	interaction_label.visible = false
	interaction_label.position = Vector2(0, -50)  # Juste au-dessus de l'Area2D
	interaction_label.modulate = Color(1, 1, 1, 1)  # Blanc opaque
	interaction_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	interaction_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	interaction_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	
	# Connecter les signaux
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

# Fixed function names (removed asterisks)
func _on_body_entered(body):
	if body == player:
		player_nearby = true
		interaction_label.text = "Appuyez sur E"
		interaction_label.visible = true
		print("🟢 Joueur détecté dans la zone d'interaction")

func _on_body_exited(body):
	if body == player:
		player_nearby = false
		interaction_label.visible = false
		print("🔴 Joueur sorti de la zone d'interaction")

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):
		start_dialogue()

func start_dialogue():
	print("💬 Début du dialogue avec l'Illusionist")
	get_tree().change_scene_to_file("res://scenes/dialogue.tscn")
