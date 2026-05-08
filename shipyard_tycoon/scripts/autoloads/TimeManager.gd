extends Node

@export var seconds_per_day: float = 2.0
@export var speed_multiplier: float = 1.0
var _time_elapsed: float = 0.0
var current_day: int = 1
var is_paused: bool = true

func _process(delta: float) -> void:
	if is_paused:
		return
	_time_elapsed += delta * speed_multiplier
	if _time_elapsed >= seconds_per_day:
		_time_elapsed -= seconds_per_day
		_advance_day()

func _advance_day() -> void:
	current_day += 1
	EventBus.day_passed.emit(current_day)
	if current_day % 30 == 0:
		EventBus.month_passed.emit(current_day / 30)

func set_pause(state: bool) -> void:
	is_paused = state

func set_speed(multiplier: float) -> void:
	speed_multiplier = max(multiplier, 0.1)
