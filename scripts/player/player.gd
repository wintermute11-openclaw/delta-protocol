extends CharacterBody2D

const BulletScene = preload("res://scenes/weapons/Bullet.tscn")
const WeaponDataScript = preload("res://scripts/weapons/weapon.gd")

@export var normal_speed: float = 160.0
@export var slow_speed: float = 80.0
@export var max_health: int = 3

@onready var camera: Camera2D = $Camera2D
@onready var muzzle: Marker2D = $Muzzle
@onready var knife_origin: Marker2D = $KnifeOrigin
@onready var body_visual: Polygon2D = $Body

var weapons: Dictionary = {}
var current_weapon_slot: int = 1
var current_weapon: WeaponData
var fire_cooldown: float = 0.0
var current_health: int = 0
var is_dead: bool = false

func _ready() -> void:
	camera.enabled = true
	current_health = max_health
	add_to_group("player")
	_setup_weapons()
	_equip_weapon(1)

func _process(delta: float) -> void:
	fire_cooldown = max(fire_cooldown - delta, 0.0)

	if is_dead:
		return

	look_at(get_global_mouse_position())
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
	if current_weapon == null:
		return

	if Input.is_action_just_pressed("fire") and fire_cooldown <= 0.0:
		if current_weapon.bullet_weapon:
			_fire_bullet_weapon()
		else:
			_fire_knife_attack()

func _fire_bullet_weapon() -> void:
	if not current_weapon.has_ammo():
		return

	var bullet := BulletScene.instantiate()
	var direction := (get_global_mouse_position() - global_position).normalized()

	bullet.global_position = muzzle.global_position
	if bullet.has_method("initialize"):
		bullet.initialize(direction, current_weapon.damage, self)

	get_tree().current_scene.add_child(bullet)
	current_weapon.consume_ammo()
	fire_cooldown = current_weapon.fire_interval

func _fire_knife_attack() -> void:
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

func take_damage(amount: int) -> void:
	if is_dead:
		return

	current_health = max(current_health - amount, 0)
	print("Player hit: ", current_health, "/", max_health)
	body_visual.color = Color(0.866667, 0.556863, 0.556863, 1)

	if current_health <= 0:
		_enter_dead_state()

func _enter_dead_state() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	body_visual.color = Color(0.317647, 0.317647, 0.352941, 1)
	print("Player down")

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
