extends CharacterBody2D

const SPEED := 150.0
const JUMP_VELOCITY := -420.0
const GRAVITY := 1100.0

@onready var anim := $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if get_tree().paused:
		anim.play("idle")
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0  
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	anim.play("idle")

	move_and_slide()
