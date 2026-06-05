class_name WeaponData
extends RefCounted

var display_name: String
var slot: int
var damage: int
var ammo: int
var fire_interval: float
var loud: bool
var bullet_weapon: bool
var range: float

func _init(
	p_display_name: String,
	p_slot: int,
	p_damage: int,
	p_ammo: int,
	p_fire_interval: float,
	p_loud: bool,
	p_bullet_weapon: bool,
	p_range: float = 0.0
) -> void:
	display_name = p_display_name
	slot = p_slot
	damage = p_damage
	ammo = p_ammo
	fire_interval = p_fire_interval
	loud = p_loud
	bullet_weapon = p_bullet_weapon
	range = p_range

func has_ammo() -> bool:
	return ammo != 0

func consume_ammo() -> void:
	if ammo > 0:
		ammo -= 1

func ammo_text() -> String:
	return "∞" if ammo < 0 else str(ammo)
