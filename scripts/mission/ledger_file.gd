extends Area2D

@onready var visual: Polygon2D = $Visual
@onready var interaction_label: Label = $InteractionLabel

var player_in_range: bool = false
var is_collected: bool = false
var mission_manager: Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	mission_manager = get_tree().get_first_node_in_group("mission_manager")
	interaction_label.visible = false

func _process(_delta: float) -> void:
	if is_collected or not player_in_range:
		return
	if Input.is_action_just_pressed("interact") and mission_manager != null:
		mission_manager.complete_optional_objective()
		is_collected = true
		visual.color = Color(0.631373, 0.584314, 0.192157, 1)
		interaction_label.text = "LEDGER-7 SECURED"
		if AudioManager != null:
			AudioManager.play_interact()
		print("Ledger file secured")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not is_collected:
		player_in_range = true
		interaction_label.visible = true
		interaction_label.text = "E: Secure LEDGER-7"

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		interaction_label.visible = false
