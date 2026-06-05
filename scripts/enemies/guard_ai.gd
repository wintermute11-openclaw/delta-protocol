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
@export var chase_speed: float = 110.0
@export var max_health: int = 2
@export var waypoint_tolerance: float = 8.0
@export var vision_range: float = 220.0
@export var vision_angle_degrees: float = 70.0
@export var attack_range: float = 120.0
@export var suspicious_wait_time: float = 1.8
@export var attack_cooldown: float = 1.0
@export var damage: int = 1

@onready var visual: Polygon2D = $Visual
@onready var vision_cone: Polygon2D = $VisionCone

var current_state: GuardState = GuardState.PATROL
var current_health: int = 0
var patrol_index: int = 0
var suspicious_timer: float = 0.0
var attack_timer: float = 0.0
var last_known_player_position: Vector2 = Vector2.ZERO
var has_last_known_player_position: bool = false
var facing_direction: Vector2 = Vector2.RIGHT
var player_ref: Node2D = null

func _ready() -> void:
	current_health = max_health
	if patrol_points.is_empty():
		patrol_points = [global_position]
	player_ref = get_tree().get_first_node_in_group("player") as Node2D
	_update_vision_cone()

func _physics_process(delta: float) -> void:
	if attack_timer > 0.0:
		attack_timer -= delta

	if current_state != GuardState.DEAD and player_ref == null:
		player_ref = get_tree().get_first_node_in_group("player") as Node2D

	match current_state:
		GuardState.PATROL:
			_patrol_state()
		GuardState.SUSPICIOUS:
			_suspicious_state(delta)
		GuardState.CHASE:
			_chase_state()
		GuardState.ATTACK:
			_attack_state()
		GuardState.DEAD:
			velocity = Vector2.ZERO

	move_and_slide()
	_update_vision_cone()

func _patrol_state() -> void:
	if _can_engage_player():
		_set_known_player_position(player_ref.global_position)
		_trigger_global_alarm("player spotted")
		_change_state(GuardState.CHASE)
		return

	if _is_global_alarm_active() and GameState.has_global_last_known_player_position:
		_set_known_player_position(GameState.global_last_known_player_position)
		_change_state(GuardState.SUSPICIOUS)
		return

	_patrol()

func _suspicious_state(delta: float) -> void:
	if _can_engage_player():
		_set_known_player_position(player_ref.global_position)
		_trigger_global_alarm("player spotted")
		_change_state(GuardState.CHASE)
		return

	if not has_last_known_player_position and _is_global_alarm_active() and GameState.has_global_last_known_player_position:
		_set_known_player_position(GameState.global_last_known_player_position)

	if not has_last_known_player_position:
		velocity = Vector2.ZERO
		suspicious_timer -= delta
		if suspicious_timer <= 0.0:
			_change_state(GuardState.PATROL)
		return

	var to_target := last_known_player_position - global_position
	if to_target.length() > waypoint_tolerance:
		_move_towards(last_known_player_position, patrol_speed)
	else:
		velocity = Vector2.ZERO
		suspicious_timer -= delta
		if suspicious_timer <= 0.0:
			has_last_known_player_position = false
			_change_state(GuardState.PATROL)

func _chase_state() -> void:
	if not _can_engage_player():
		if _is_global_alarm_active() and GameState.has_global_last_known_player_position:
			_set_known_player_position(GameState.global_last_known_player_position)
		if GameState != null and GameState.alarm_state != GameState.AlarmState.ALARM:
			GameState.raise_suspicion("lost visual contact")
		_change_state(GuardState.SUSPICIOUS)
		return

	_set_known_player_position(player_ref.global_position)
	var distance_to_player := global_position.distance_to(player_ref.global_position)
	_face_towards(player_ref.global_position)

	if distance_to_player <= attack_range:
		velocity = Vector2.ZERO
		_change_state(GuardState.ATTACK)
		return

	_move_towards(player_ref.global_position, chase_speed)

func _attack_state() -> void:
	if not _can_engage_player():
		if _is_global_alarm_active() and GameState.has_global_last_known_player_position:
			_set_known_player_position(GameState.global_last_known_player_position)
		if GameState != null and GameState.alarm_state != GameState.AlarmState.ALARM:
			GameState.raise_suspicion("lost visual contact")
		_change_state(GuardState.SUSPICIOUS)
		return

	_set_known_player_position(player_ref.global_position)
	var distance_to_player := global_position.distance_to(player_ref.global_position)
	_face_towards(player_ref.global_position)
	velocity = Vector2.ZERO

	if distance_to_player > attack_range:
		_change_state(GuardState.CHASE)
		return

	if attack_timer <= 0.0 and player_ref.has_method("take_damage"):
		player_ref.take_damage(damage)
		attack_timer = attack_cooldown

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

	_move_towards(target_point, patrol_speed)

func _move_towards(target_position: Vector2, speed: float) -> void:
	var direction := target_position - global_position
	if direction.length() <= 0.001:
		velocity = Vector2.ZERO
		return

	velocity = direction.normalized() * speed
	facing_direction = direction.normalized()
	rotation = facing_direction.angle()

func _face_towards(target_position: Vector2) -> void:
	var direction := target_position - global_position
	if direction.length() <= 0.001:
		return
	facing_direction = direction.normalized()
	rotation = facing_direction.angle()

func _can_engage_player() -> bool:
	if current_state == GuardState.DEAD:
		return false
	if player_ref == null or not is_instance_valid(player_ref):
		return false
	if player_ref.has_method("is_alive") and not player_ref.is_alive():
		return false

	var to_player := player_ref.global_position - global_position
	if to_player.length() > vision_range:
		return false

	var forward := facing_direction.normalized()
	if forward == Vector2.ZERO:
		forward = Vector2.RIGHT

	var direction_to_player := to_player.normalized()
	var angle_to_player := rad_to_deg(acos(clamp(forward.dot(direction_to_player), -1.0, 1.0)))
	if angle_to_player > vision_angle_degrees * 0.5:
		return false

	var space_state := get_world_2d().direct_space_state
	var ray_query := PhysicsRayQueryParameters2D.create(global_position, player_ref.global_position)
	ray_query.exclude = [self]
	ray_query.collision_mask = 1
	var result := space_state.intersect_ray(ray_query)

	if result.is_empty():
		return true

	return result.get("collider") == player_ref

func _change_state(new_state: GuardState) -> void:
	if current_state == new_state:
		return

	current_state = new_state
	match current_state:
		GuardState.SUSPICIOUS:
			suspicious_timer = suspicious_wait_time
		GuardState.CHASE:
			pass
		GuardState.ATTACK:
			pass
		GuardState.PATROL:
			velocity = Vector2.ZERO
		GuardState.DEAD:
			velocity = Vector2.ZERO

	print(name, " state -> ", GuardState.keys()[current_state])

func _update_vision_cone() -> void:
	var forward := facing_direction.normalized()
	if forward == Vector2.ZERO:
		forward = Vector2.RIGHT

	var half_angle := deg_to_rad(vision_angle_degrees * 0.5)
	var left_point := forward.rotated(-half_angle) * vision_range
	var right_point := forward.rotated(half_angle) * vision_range
	vision_cone.polygon = PackedVector2Array([Vector2.ZERO, left_point, right_point])

func _set_known_player_position(position: Vector2) -> void:
	last_known_player_position = position
	has_last_known_player_position = true
	if GameState != null:
		GameState.set_last_known_player_position(position)

func _trigger_global_alarm(reason: String) -> void:
	if GameState == null:
		return
	if reason == "player spotted":
		GameState.trigger_alarm("player spotted")
		return
	GameState.trigger_alarm(reason)

func _is_global_alarm_active() -> bool:
	return GameState != null and GameState.alarm_state == GameState.AlarmState.ALARM

func take_damage(amount: int) -> void:
	if current_state == GuardState.DEAD or amount <= 0:
		return

	current_health -= amount
	visual.color = Color(0.529412, 0.176471, 0.176471, 1)
	if AudioManager != null:
		AudioManager.play_hit()

	if current_health <= 0:
		_enter_dead_state()

func _enter_dead_state() -> void:
	_change_state(GuardState.DEAD)
	visual.color = Color(0.211765, 0.211765, 0.235294, 0.85)
	vision_cone.visible = false
	modulate = Color(1, 1, 1, 0.8)
