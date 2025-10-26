extends Node

@onready var popup := $QuestionPopup
@onready var http := $HTTPRequest

var current_enemy = null

func start_encounter(enemy):
	current_enemy = enemy
	get_tree().paused = true
	
	popup.show_question("Write a function that returns the sum of 2 and 2:")
	if not popup.answer_submitted.is_connected(_on_answer_submitted):
		popup.answer_submitted.connect(_on_answer_submitted)

func _on_answer_submitted(answer: String):
	var payload = {
		"question": popup.question_label.text,
		"answer": answer
	}
	var json = JSON.stringify(payload)

	http.request(
		"http://localhost:5000/grade", 
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST, 
		json
	)
	http.request_completed.connect(_on_request_completed)

func _on_request_completed(result, code, headers, body):
	http.request_completed.disconnect(_on_request_completed)

	popup.hide_question()
	get_tree().paused = false

	var data = JSON.parse_string(body.get_string_from_utf8())
	if data and data.correct:
		print("Correct: Gained robot part!")
		current_enemy.on_defeated()
	else:
		print("Incorrect: " + data.feedback)
		# TODO: apply damage to player

	current_enemy = null
