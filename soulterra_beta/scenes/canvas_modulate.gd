extends CanvasModulate
class_name DayAndNightCycle

signal changeDayTime(daytime: DAY_STATE)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum DAY_STATE{NOON, EVENING}

var dayTime : DAY_STATE = DAY_STATE.NOON

func _ready() -> void:
	add_to_group("DayAndNightCycle")
	# Mulai animasi new_animation
	animation_player.play("new_animation")
	
func _process(_delta: float) -> void:
	# Cek apakah animasi sedang berjalan
	if !animation_player.is_playing():
		return
		
	var animationPos = animation_player.current_animation_position
	var animationLength = animation_player.current_animation_length / 2
	
	if animationPos > animationLength && dayTime != DAY_STATE.EVENING:
		dayTime = DAY_STATE.EVENING
		changeDayTime.emit(dayTime)
	elif animationPos < animationLength && dayTime != DAY_STATE.NOON:
		dayTime = DAY_STATE.NOON
		changeDayTime.emit(dayTime)
