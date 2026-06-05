extends Area2D

@onready var visual: Polygon2D = $Visual
@onready var interaction_label: Label = $InteractionLabel

var player_in_range: bool = false
var is_complete: bool = false
var mission_manager: Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	mission_manager = get_tree().get_first_node_in_group("mission_manager")
	interaction_label.visible = false

func _process(_delta: float) -> void:
	if is_complete or not player_in_range:
		return
	if Input.is_action_just_pressed("interact") and mission_manager != null:
		mission_manager.complete_primary_objective()
		is_complete = true
		visual.color = Color(0.235294, 0.6, 0.352941, 1)
		interaction_label.text = "SERVER DATA COPIED"
		if AudioManager != null:
			AudioManager.play_interact()
		print("Server terminal used")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not is_complete:
		player_in_range = true
		interaction_label.visible = true
		interaction_label.text = "E: Copy KRONOS data"

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		interaction_label.visible = false
