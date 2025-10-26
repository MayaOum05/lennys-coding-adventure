extends CharacterBody2D

@export var speed := 40.0
@export var question_ui_path: NodePath

var ui
var triggered := false

var questions = [
	{"q": "What does 2+2 equal?", "choices": ["1","2","3","4"], "correct": 3},
	{"q": "Which is a fruit?", "choices": ["Dog","Car","Apple","Shoe"], "correct": 2},
	{"q": "What color is the sky?", "choices": ["Green","Blue","Red","Black"], "correct": 1}
]

func _ready():
	ui = get_node(question_ui_path)
	$DetectionArea.body_entered.connect(_on_player_touch)

func _physics_process(delta):
	if not triggered:
		velocity.x = -speed
		move_and_slide()

func _on_player_touch(body):
	if body.is_in_group("player") and not triggered:
		triggered = true
		velocity = Vector2.ZERO
		var q = questions[randi() % questions.size()]
		ui.show_question(q["q"], q["choices"], q["correct"])
		ui.answer_chosen.connect(_handle_answer)

func _handle_answer(is_correct: bool):
	if is_correct:
		print("✅ Correct! Enemy defeated!")
		queue_free()
	else:
		print("❌ Wrong! Player takes damage!")
		triggered = false
