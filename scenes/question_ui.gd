extends Control

signal answer_chosen(is_correct: bool)

@onready var label := $Panel/QuestionLabel
@onready var buttons := [
	$Panel/Choice0,
	$Panel/Choice1,
	$Panel/Choice2,
	$Panel/Choice3
]

var correct_index := 0

func show_question(text: String, choices: Array, correct: int):
	visible = true
	label.text = text
	correct_index = correct

	for i in range(choices.size()):
		buttons[i].text = choices[i]
		if not buttons[i].pressed.is_connected(_on_choice_pressed):
			buttons[i].pressed.connect(_on_choice_pressed.bind(i))

func hide_question():
	visible = false
	for btn in buttons:
		if btn.pressed.is_connected(_on_choice_pressed):
			btn.pressed.disconnect(_on_choice_pressed)

func _on_choice_pressed(i: int):
	emit_signal("answer_chosen", i == correct_index)
	hide_question()
