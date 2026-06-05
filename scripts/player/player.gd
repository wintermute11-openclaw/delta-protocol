extends CharacterBody2D

@export var normal_speed: float = 160.0
@export var slow_speed: float = 80.0

@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	camera.enabled = true

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var current_speed := slow_speed if Input.is_action_pressed("slow_move") else normal_speed

	velocity = input_vector * current_speed
	move_and_slide()
	look_at(get_global_mouse_position())
