extends Area2D

@onready var status_label: Label = $StatusLabel
@onready var visual: Polygon2D = $Visual

var player_inside: bool = false
var mission_manager: Node = null
var warned_incomplete: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	mission_manager = get_tree().get_first_node_in_group("mission_manager")
	status_label.visible = false

func _process(_delta: float) -> void:
	if not player_inside or mission_manager == null:
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
		warned_incomplete = false
		if mission_manager != null and not mission_manager.can_exfil():
			status_label.visible = true
			status_label.text = "Primary objective incomplete"

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false
		warned_incomplete = false
		status_label.visible = false
