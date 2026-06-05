extends CharacterBody2D

enum GuardState {
	PATROL,
	SUSPICIOUS,
	CHASE,
	ATTACK,
	DEAD,
}

@export var patrol_points: Array[Vector2] = [Vector2.ZERO, Vector2(96, 0)]
@export var patrol_speed: float = 72.0
@export var max_health: int = 2
@export var waypoint_tolerance: float = 8.0

@onready var visual: Polygon2D = $Visual

var current_state: GuardState = GuardState.PATROL
var current_health: int = 0
var patrol_index: int = 0

func _ready() -> void:
	current_health = max_health
	if patrol_points.is_empty():
		patrol_points = [global_position]

func _physics_process(_delta: float) -> void:
	match current_state:
		GuardState.PATROL:
			_patrol()
		GuardState.DEAD:
			velocity = Vector2.ZERO
		# Reserved for later phases:
		# SUSPICIOUS becomes active in Phase 4.
		# CHASE and ATTACK become active in later combat/detection phases.
		GuardState.SUSPICIOUS, GuardState.CHASE, GuardState.ATTACK:
			velocity = Vector2.ZERO

	move_and_slide()

func _patrol() -> void:
	if patrol_points.is_empty():
		velocity = Vector2.ZERO
		return

	var target_point := patrol_points[patrol_index]
	var to_target := target_point - global_position

	if to_target.length() <= waypoint_tolerance:
		patrol_index = (patrol_index + 1) % patrol_points.size()
		target_point = patrol_points[patrol_index]
		to_target = target_point - global_position

	velocity = to_target.normalized() * patrol_speed
	if velocity.length() > 0.0:
		rotation = velocity.angle()

func take_damage(amount: int) -> void:
	if current_state == GuardState.DEAD:
		return

	current_health -= amount
	visual.color = Color(0.529412, 0.176471, 0.176471, 1)

	if current_health <= 0:
		_enter_dead_state()

func _enter_dead_state() -> void:
	current_state = GuardState.DEAD
	velocity = Vector2.ZERO
	visual.color = Color(0.211765, 0.211765, 0.235294, 0.85)
	modulate = Color(1, 1, 1, 0.8)
