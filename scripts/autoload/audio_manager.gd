extends Node

const MP5SD_STREAM_PATH := "res://assets/audio/sfx/mp5sd_placeholder.wav"
const BERETTA_STREAM_PATH := "res://assets/audio/sfx/beretta_placeholder.wav"
const HIT_STREAM_PATH := "res://assets/audio/sfx/hit_placeholder.wav"
const ALARM_STREAM_PATH := "res://assets/audio/sfx/alarm_placeholder.wav"
const INTERACT_STREAM_PATH := "res://assets/audio/sfx/interact_placeholder.wav"

var mp5sd_player: AudioStreamPlayer
var beretta_player: AudioStreamPlayer
var hit_player: AudioStreamPlayer
var alarm_player: AudioStreamPlayer
var interact_player: AudioStreamPlayer

func _ready() -> void:
	mp5sd_player = _make_player("MP5SDPlayer", _load_stream(MP5SD_STREAM_PATH), -14.0)
	beretta_player = _make_player("BerettaPlayer", _load_stream(BERETTA_STREAM_PATH), -8.0)
	hit_player = _make_player("HitPlayer", _load_stream(HIT_STREAM_PATH), -12.0)
	alarm_player = _make_player("AlarmPlayer", _load_stream(ALARM_STREAM_PATH), -10.0)
	interact_player = _make_player("InteractPlayer", _load_stream(INTERACT_STREAM_PATH), -16.0)
	if GameState != null and GameState.has_signal("alarm_state_changed") and not GameState.alarm_state_changed.is_connected(_on_alarm_state_changed):
		GameState.alarm_state_changed.connect(_on_alarm_state_changed)

func play_mp5sd() -> void:
	_play_player(mp5sd_player)

func play_beretta() -> void:
	_play_player(beretta_player)

func play_hit() -> void:
	_play_player(hit_player)

func play_alarm() -> void:
	_play_player(alarm_player)

func play_interact() -> void:
	_play_player(interact_player)

func _on_alarm_state_changed(new_state: int, _reason: String) -> void:
	if GameState != null and new_state == GameState.AlarmState.ALARM:
		play_alarm()

func _make_player(node_name: String, stream: AudioStream, volume_db: float) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.name = node_name
	player.stream = stream
	player.volume_db = volume_db
	add_child(player)
	return player

func _load_stream(path: String) -> AudioStream:
	if not ResourceLoader.exists(path):
		push_warning("Audio stream missing or not imported yet: %s" % path)
		return null
	return load(path) as AudioStream

func _play_player(player: AudioStreamPlayer) -> void:
	if player == null or player.stream == null:
		return
	player.stop()
	player.play()
