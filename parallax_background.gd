extends ParallaxBackground

@onready var forest: ParallaxLayer = $ParallaxLayer
@onready var forest2: ParallaxLayer = $ParallaxLayer2

@export var forestSpeed = 0.1

func _process(_delta: float) -> void:
	forest.motion_offset -= Vector2(forestSpeed, 0)
	forest2.motion_offset -= Vector2(forestSpeed, 0)
