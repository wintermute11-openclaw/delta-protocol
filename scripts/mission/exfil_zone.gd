extends Area2D

@onready var status_label: Label = $StatusLabel
@onready var visual: Polygon2D = $Visual

var player_inside: bool = false
var mission_manager: Node = null
var warned_incomplete: bool = false
var player_ref: Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	mission_manager = get_tree().get_first_node_in_group("mission_manager")
	status_label.visible = false

func _process(_delta: float) -> void:
	if not player_inside or mission_manager == null or not _player_can_exfil():
		return
	if mission_manager.can_exfil():
		mission_manager.complete_mission()
		status_label.visible = true
		status_label.text = "EXFIL COMPLETE"
		visual.color = Color(0.211765, 0.556863, 0.313726, 0.35)
		return
	if not warned_incomplete:
		warned_incomplete = true
		status_label.visible = true
		status_label.text = "Primary objective incomplete"
		print("Primary objective incomplete")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = true
		player_ref = body
		warned_incomplete = false
		if not _player_can_exfil():
			status_label.visible = false
			return
		if mission_manager != null and not mission_manager.can_exfil():
			status_label.visible = true
			status_label.text = "Primary objective incomplete"

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false
		player_ref = null
		warned_incomplete = false
		status_label.visible = false

func _player_can_exfil() -> bool:
	if player_ref == null:
		return false
	if player_ref.has_method("is_alive"):
		return player_ref.is_alive()
	return true
