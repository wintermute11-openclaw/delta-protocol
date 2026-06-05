extends Area2D

@export var speed: float = 620.0
@export var lifetime: float = 1.5

var direction: Vector2 = Vector2.RIGHT
var damage: int = 1
var instigator: Node = null
var time_alive: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func initialize(p_direction: Vector2, p_damage: int, p_instigator: Node) -> void:
	direction = p_direction.normalized()
	damage = p_damage
	instigator = p_instigator
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	time_alive += delta

	if time_alive >= lifetime:
		queue_free()

func _on_body_entered(body: Node) -> void:
	_handle_hit(body)

func _on_area_entered(area: Area2D) -> void:
	_handle_hit(area)

func _handle_hit(target: Node) -> void:
	if target == null or target == instigator:
		return

	if target.has_method("take_damage"):
		target.take_damage(damage)

	queue_free()
