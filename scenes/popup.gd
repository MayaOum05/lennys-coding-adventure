extends CanvasLayer

signal answer_submitted(answer: String)

@onready var panel := $Panel
@onready var question_label := $Panel/QuestionLabel
@onready var answer_box := $Panel/AnswerBox
@onready var submit_button := $Panel/SubmitButton

func _ready():
	visible = false
	panel.visible = false
	submit_button.pressed.connect(_on_submit_pressed)

func show_question(text: String):
	question_label.text = text
	answer_box.text = ""  # Clear previous input
	visible = true
	panel.visible = true
	answer_box.grab_focus()

func hide_question():
	visible = false
	panel.visible = false

func _on_submit_pressed():
	emit_signal("answer_submitted", answer_box.text)
