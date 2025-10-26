extends Node

@export var popup_scene: PackedScene
var popup: Node

var question_bank = [
	"Write code that returns 2 + 2.",
	"Write a function that prints 'Hello World'.",
	"Declare a variable named x and set it to 10.",
	"Write a while loop that counts to 5.",
	"Return the larger of two numbers."
]


var current_enemy: Node = null

func _ready():
	if popup_scene:
		popup = popup_scene.instantiate()
		add_child(popup)
		popup.visible = false
	else:
		push_error("popup_scene not assigned in Inspector!")


func start_encounter(enemy: Node):
	current_enemy = enemy
	get_tree().paused = true

	var q = question_bank[randi() % question_bank.size()]
	popup.show_question(q)

	if not popup.answer_submitted.is_connected(_on_answer_submitted):
		popup.answer_submitted.connect(_on_answer_submitted)

func _on_answer_submitted(answer: String):
	if answer.strip_edges() == "":
		_print_wrong("You must write something!")
		return

	_print_correct()
	current_enemy.on_defeated()

	get_tree().paused = false
	popup.hide_question()
	current_enemy = null

func _print_correct():
	print("Correct! Gained robot part!")

func _print_wrong(msg: String):
	print("Incorrect:", msg)
	# TODO: Apply health damage
	# For now, still unpause game:
	get_tree().paused = false
	popup.hide_question()
	current_enemy = null
