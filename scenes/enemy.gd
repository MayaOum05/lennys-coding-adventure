extends CharacterBody2D

@export var chase_speed: float = 70.0
var player: Node2D
var player_near := false

signal question_triggered(enemy)

func _ready():
	# Find the first node in group "player"
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	else:
		print("No player found in group 'player'")

	$DetectionArea.body_entered.connect(_on_player_enter)
	$DetectionArea.body_exited.connect(_on_player_exit)

func _physics_process(_delta):
	if player_near and not get_tree().paused:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * chase_speed
		move_and_slide()

func _on_player_enter(body):
	if body.is_in_group("player"):
		player_near = true
		print("Enemy says: QUESTION TRIGGERED!")
		emit_signal("question_triggered", self)

func _on_player_exit(body):
	if body.is_in_group("player"):
		player_near = false
		velocity = Vector2.ZERO
