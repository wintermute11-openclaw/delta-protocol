extends Node

signal mission_updated
signal mission_completed

var primary_objective_complete: bool = false
var optional_objective_complete: bool = false
var exfil_available: bool = false
var mission_complete: bool = false
var current_objective_text: String = "Copy KRONOS server data"

func _ready() -> void:
	add_to_group("mission_manager")
	if GameState != null:
		GameState.reset_alarm()
	_emit_update()

func complete_primary_objective() -> void:
	if primary_objective_complete:
		return
	primary_objective_complete = true
	exfil_available = true
	current_objective_text = "Reach roof exfil zone"
	print("Primary objective complete: KRONOS server data copied")
	_emit_update()

func complete_optional_objective() -> void:
	if optional_objective_complete:
		return
	optional_objective_complete = true
	print("Optional objective complete: LEDGER-7 secured")
	_emit_update()

func can_exfil() -> bool:
	return primary_objective_complete and not mission_complete

func complete_mission() -> void:
	if mission_complete or not can_exfil():
		return
	mission_complete = true
	current_objective_text = "Mission complete"
	print("Mission complete: Operation Silent Ledger")
	emit_signal("mission_completed")
	_emit_update()

func get_objective_text() -> String:
	return current_objective_text

func get_optional_objective_text() -> String:
	return "Secure LEDGER-7 [%s]" % ("DONE" if optional_objective_complete else "OPEN")

func _emit_update() -> void:
	emit_signal("mission_updated")
