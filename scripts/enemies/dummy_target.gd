extends StaticBody2D

@export var max_health: int = 2

var current_health: int = 0

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int) -> void:
	if amount <= 0:
		return
	current_health -= amount
	if AudioManager != null:
		AudioManager.play_hit()
	if current_health <= 0:
		queue_free()
