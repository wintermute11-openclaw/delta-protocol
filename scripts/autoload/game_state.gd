extends Node

signal alarm_state_changed(new_state: int, reason: String)

enum AlarmState {
	NORMAL,
	SUSPICIOUS,
	ALARM,
}

var alarm_state: AlarmState = AlarmState.NORMAL
var global_last_known_player_position: Vector2 = Vector2.ZERO
var has_global_last_known_player_position: bool = false

func set_alarm_state(new_state: AlarmState, reason: String = "") -> void:
	if alarm_state == new_state:
		if new_state != AlarmState.NORMAL and has_global_last_known_player_position:
			print("Alarm persists: ", get_alarm_state_name(), " reason=", reason)
		return

	alarm_state = new_state
	print("Alarm state -> ", get_alarm_state_name(), " reason=", reason)
	emit_signal("alarm_state_changed", alarm_state, reason)

func raise_suspicion(reason: String = "") -> void:
	if alarm_state == AlarmState.ALARM:
		return
	set_alarm_state(AlarmState.SUSPICIOUS, reason)

func trigger_alarm(reason: String = "") -> void:
	set_alarm_state(AlarmState.ALARM, reason)

func reset_alarm() -> void:
	has_global_last_known_player_position = false
	global_last_known_player_position = Vector2.ZERO
	set_alarm_state(AlarmState.NORMAL, "reset")

func get_alarm_state_name() -> String:
	return AlarmState.keys()[alarm_state]

func set_last_known_player_position(position: Vector2) -> void:
	global_last_known_player_position = position
	has_global_last_known_player_position = true

func clear_last_known_player_position() -> void:
	has_global_last_known_player_position = false
	global_last_known_player_position = Vector2.ZERO
