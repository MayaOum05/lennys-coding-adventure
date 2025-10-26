extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -420.0
const GRAVITY = 1100.0

@onready var anim := $AnimatedSprite2D

func _ready():
	# ✅ No matter what, game starts unpaused!!!
	get_tree().paused = false

func _physics_process(delta):
	# ✅ Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# ✅ Left/Right Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	# ✅ Flip Sprite
	if direction != 0:
		anim.flip_h = direction < 0

	# ✅ Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	anim.play("idle")
	move_and_slide()
