extends CharacterBody2D

signal player_died
signal health_changed(current_health: int, max_health: int)

const BulletScene = preload("res://scenes/weapons/Bullet.tscn")
const WeaponDataScript = preload("res://scripts/weapons/weapon.gd")
const SPRITE_CONFIG_PATH := "res://assets/sprites/player/delta_soldier_8dir.json"
const DIRECTION_NAMES := ["e", "se", "s", "sw", "w", "nw", "n", "ne"]
const MUZZLE_DISTANCE := 18.0
const KNIFE_DISTANCE := 20.0
const BODY_COLOR_NORMAL := Color(1, 1, 1, 1)
const BODY_COLOR_HIT := Color(0.866667, 0.556863, 0.556863, 1)
const BODY_COLOR_DEAD := Color(0.317647, 0.317647, 0.352941, 1)
const BREATHING_SPEED := 2.2
const BREATHING_SCALE_AMOUNT := 0.02
const BREATHING_BOB_AMOUNT := 1.5

@export var normal_speed: float = 160.0
@export var slow_speed: float = 80.0
@export var max_health: int = 3

@onready var camera: Camera2D = $Camera2D
@onready var muzzle: Marker2D = $Muzzle
@onready var knife_origin: Marker2D = $KnifeOrigin
@onready var body_visual: Sprite2D = $Body

var weapons: Dictionary = {}
var current_weapon_slot: int = 1
var current_weapon = null
var fire_cooldown: float = 0.0
var current_health: int = 0
var is_dead: bool = false
var sprite_regions: Dictionary = {}
var sprite_anchors: Dictionary = {}
var current_facing: String = "s"
var current_anchor: Vector2 = Vector2.ZERO
var breathing_time: float = 0.0

func _ready() -> void:
	camera.enabled = true
	current_health = max_health
	add_to_group("player")
	_setup_weapons()
	_load_sprite_config()
	_update_aim(Vector2.DOWN)
	_set_body_tint(BODY_COLOR_NORMAL)
	_equip_weapon(1)
	emit_signal("health_changed", current_health, max_health)

func _process(delta: float) -> void:
	fire_cooldown = max(fire_cooldown - delta, 0.0)
	if not is_dead:
		breathing_time += delta
	_refresh_body_transform()

	if Input.is_action_just_pressed("restart") and is_dead:
		get_tree().reload_current_scene()
		return

	if is_dead:
		return

	var aim_vector := get_global_mouse_position() - global_position
	_update_aim(aim_vector)
	_handle_weapon_switch()
	_handle_attack_input()

func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var current_speed := slow_speed if Input.is_action_pressed("slow_move") else normal_speed

	velocity = input_vector * current_speed
	move_and_slide()

func _setup_weapons() -> void:
	weapons[1] = WeaponDataScript.new("MP5SD", 1, 1, 90, 0.12, false, true)
	weapons[2] = WeaponDataScript.new("Beretta M9", 2, 1, 30, 0.3, true, true)
	weapons[3] = WeaponDataScript.new("Knife", 3, 2, -1, 0.4, false, false, 28.0)

func _load_sprite_config() -> void:
	if not ResourceLoader.exists(SPRITE_CONFIG_PATH):
		push_warning("Player sprite config missing: %s" % SPRITE_CONFIG_PATH)
		return

	var json_text := FileAccess.get_file_as_string(SPRITE_CONFIG_PATH)
	var parsed: Variant = JSON.parse_string(json_text)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("Player sprite config is invalid JSON: %s" % SPRITE_CONFIG_PATH)
		return

	var config: Dictionary = parsed
	var texture_path := String(config.get("texture_path", ""))
	if not texture_path.is_empty():
		body_visual.texture = load(texture_path)
		body_visual.region_enabled = true

	var directions: Dictionary = config.get("directions", {})
	for direction_name in directions.keys():
		var entry_variant: Variant = directions[direction_name]
		if typeof(entry_variant) != TYPE_DICTIONARY:
			continue
		var entry: Dictionary = entry_variant
		var region_data: Array = entry.get("region", [])
		var anchor_data: Array = entry.get("anchor", [])
		if region_data.size() == 4:
			sprite_regions[String(direction_name)] = Rect2(
				float(region_data[0]),
				float(region_data[1]),
				float(region_data[2]),
				float(region_data[3])
			)
		if anchor_data.size() == 2:
			sprite_anchors[String(direction_name)] = Vector2(
				float(anchor_data[0]),
				float(anchor_data[1])
			)

	_apply_body_direction(current_facing)

func _update_aim(aim_vector: Vector2) -> void:
	if aim_vector.length_squared() <= 0.0001:
		return

	var aim_direction := aim_vector.normalized()
	muzzle.position = aim_direction * MUZZLE_DISTANCE
	knife_origin.position = aim_direction * KNIFE_DISTANCE
	_apply_body_direction(_direction_name_from_vector(aim_direction))

func _direction_name_from_vector(direction: Vector2) -> String:
	var angle := wrapf(direction.angle(), 0.0, TAU)
	var direction_index := int(round(angle / (PI / 4.0))) % DIRECTION_NAMES.size()
	return DIRECTION_NAMES[direction_index]

func _apply_body_direction(direction_name: String) -> void:
	if not sprite_regions.has(direction_name):
		return

	var region: Rect2 = sprite_regions[direction_name]
	body_visual.region_rect = region
	var default_anchor := Vector2(region.size.x * 0.5, region.size.y)
	current_anchor = sprite_anchors.get(direction_name, default_anchor)
	current_facing = direction_name
	_refresh_body_transform()

func _refresh_body_transform() -> void:
	if current_anchor == Vector2.ZERO:
		return

	if is_dead:
		body_visual.scale = Vector2.ONE
		body_visual.position = -current_anchor
		return

	var breath_wave := sin(breathing_time * TAU * BREATHING_SPEED * 0.5)
	var scale_y := 1.0 + breath_wave * BREATHING_SCALE_AMOUNT
	var bob_offset: float = absf(breath_wave) * BREATHING_BOB_AMOUNT
	body_visual.scale = Vector2(1.0, scale_y)
	body_visual.position = Vector2(-current_anchor.x, -current_anchor.y * scale_y - bob_offset)

func _set_body_tint(color: Color) -> void:
	body_visual.modulate = color

func _handle_weapon_switch() -> void:
	if Input.is_action_just_pressed("weapon_1"):
		_equip_weapon(1)
	elif Input.is_action_just_pressed("weapon_2"):
		_equip_weapon(2)
	elif Input.is_action_just_pressed("weapon_3"):
		_equip_weapon(3)

func _equip_weapon(slot: int) -> void:
	if not weapons.has(slot):
		return

	current_weapon_slot = slot
	current_weapon = weapons[slot]

func _handle_attack_input() -> void:
	if current_weapon == null or is_dead:
		return

	if Input.is_action_just_pressed("fire") and fire_cooldown <= 0.0:
		if current_weapon.bullet_weapon:
			_fire_bullet_weapon()
		else:
			_fire_knife_attack()

func _fire_bullet_weapon() -> void:
	if is_dead or not current_weapon.has_ammo():
		return

	var bullet := BulletScene.instantiate()
	var direction := (get_global_mouse_position() - global_position).normalized()

	bullet.global_position = muzzle.global_position
	if bullet.has_method("initialize"):
		bullet.initialize(direction, current_weapon.damage, self)

	get_tree().current_scene.add_child(bullet)
	current_weapon.consume_ammo()
	fire_cooldown = current_weapon.fire_interval
	_play_weapon_audio()

	if current_weapon.loud and GameState != null:
		GameState.set_last_known_player_position(global_position)
		GameState.trigger_alarm("loud weapon fired")

func _fire_knife_attack() -> void:
	if is_dead:
		return

	var space_state := get_world_2d().direct_space_state
	var shape := CircleShape2D.new()
	shape.radius = current_weapon.range

	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0.0, knife_origin.global_position)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	query.collision_mask = 1

	for result in space_state.intersect_shape(query, 8):
		var collider: Object = result.get("collider")
		if collider == self:
			continue
		if collider != null and collider.has_method("take_damage"):
			collider.take_damage(current_weapon.damage)
			break

	fire_cooldown = current_weapon.fire_interval

func _play_weapon_audio() -> void:
	if AudioManager == null:
		return
	if current_weapon == null:
		return
	match current_weapon.display_name:
		"MP5SD":
			AudioManager.play_mp5sd()
		"Beretta M9":
			AudioManager.play_beretta()

func take_damage(amount: int) -> void:
	if is_dead or amount <= 0:
		return

	current_health = max(current_health - amount, 0)
	print("Player hit: ", current_health, "/", max_health)
	_set_body_tint(BODY_COLOR_HIT)
	emit_signal("health_changed", current_health, max_health)
	if AudioManager != null:
		AudioManager.play_hit()

	if current_health <= 0:
		_enter_dead_state()

func _enter_dead_state() -> void:
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	_refresh_body_transform()
	_set_body_tint(BODY_COLOR_DEAD)
	print("Player down")
	emit_signal("player_died")

func is_alive() -> bool:
	return not is_dead

func get_weapon_status_text() -> String:
	if current_weapon == null:
		return "Unarmed"

	return "%s | Ammo: %s | Loud: %s" % [
		current_weapon.display_name,
		current_weapon.ammo_text(),
		"yes" if current_weapon.loud else "no"
	]

func get_health_status_text() -> String:
	return "%s/%s" % [current_health, max_health]
