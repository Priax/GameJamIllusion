extends Control

@onready var label = $DialogueBubble/Label
@onready var dialogue_bubble = $DialogueBubble

var hypnosis = null

var dialogue = [
	{"speaker": "Illusionist Master", "text": "Punctual. I like that. But tell me… what do you believe is real?"},
	{"speaker": "You", "text": "What kind of question is that? Reality is what we can see and touch."},
	{"speaker": "Illusionist Master", "text": "Words can only reveal so much. True understanding comes through experience. Let’s see if your mind is sharp enough to perceive beyond the veil."},
	{"speaker": "You", "text": "What do you mean?"},
	{"speaker": "Illusionist Master", "text": "(snaps his fingers—suddenly, the tavern distorts, flickering like a mirage.) A test. Three illusions. Solve them, and you may earn a place among us."},
	{"speaker": "You", "text": "I came here because of your letter. Not for riddles."},
	{"speaker": "Illusionist Master", "text": "(leans in, eyes glinting in the dim candlelight) And yet, aren't riddles the gateway to truth? You accepted my invitation. That means you’re willing to question... or at least, you’re curious."},
	{"speaker": "You", "text": "Fine. Let’s say I entertain this thought. Why invite me?"},
	{"speaker": "Illusionist Master", "text": "(smiles knowingly) Because you are about to witness an illusion so grand… that even reality will start to doubt itself."}
]

var dialogue_index = 0
var typing_speed = 0.1
var line_wait_time = 0.5
var is_typing = false

const MAX_LINE_LENGTH = 40

func _ready():
	hypnosis = get_node("../Hypnosis")

	if hypnosis == null:
		print("ERROR: Hypnosis node not found. Check the node path.")
	else:
		hypnosis.visible = false

	show_dialogue()
	set_process_input(true)

func show_dialogue():
	if dialogue_index < dialogue.size():
		var entry = dialogue[dialogue_index]

		if entry["speaker"] == "Illusionist Master":
			dialogue_bubble.set_position(Vector2(1400, 400))
		else:
			dialogue_bubble.set_position(Vector2(850, 400))
		
		dialogue_bubble.show()
		start_typing(entry["speaker"], entry["text"])
	else:
		dialogue_bubble.hide()
		start_hypnosis()

func start_typing(speaker: String, text: String):
	is_typing = true
	label.add_theme_font_size_override("font_size", 36)
	label.text = speaker + "\n"

	var lines = wrap_text(text, MAX_LINE_LENGTH)
	
	for line in lines:
		label.text += line + "\n"
		for i in range(line.length()):
			label.text = speaker + "\n" + line.substr(0, i + 1)
			await get_tree().create_timer(typing_speed).timeout

		await get_tree().create_timer(line_wait_time).timeout
	
	is_typing = false
	dialogue_index += 1
	show_dialogue()

func wrap_text(text: String, max_line_length: int) -> Array:
	var lines = []
	var current_line = ""
	var words = text.split(" ")

	for word in words:
		if current_line.length() + word.length() + 1 > max_line_length:
			lines.append(current_line)
			current_line = word
		else:
			if current_line != "":
				current_line += " "
			current_line += word

	if current_line != "":
		lines.append(current_line)

	return lines

func start_hypnosis():
	if hypnosis != null:
		hypnosis.visible = true
		hypnosis.play("Hypnosis")

		await hypnosis.animation_finished

		change_scene()
	else:
		print("ERROR: Hypnosis node is still null, unable to play animation.")

func change_scene():
	get_tree().change_scene("res://path/to/your/next_scene.tscn")
