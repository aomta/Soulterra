extends StaticBody2D

var current_weather = "none"
var day_night_cycle = null
var is_evening = false

@onready var rain_sfx = $RainSFX

func _ready():
	update_weather_visibility()
	
	day_night_cycle = get_tree().get_first_node_in_group("DayAndNightCycle")
	
	if day_night_cycle:
		day_night_cycle.changeDayTime.connect(_on_day_time_changed)
	
	$Timer.wait_time = randf_range(5, 12)
	$Timer.start()
		
func _on_day_time_changed(daytime):
	is_evening = (daytime == day_night_cycle.DAY_STATE.EVENING)
		
func _on_timer_timeout():
	if current_weather == "none":
		var rain_chance = 0.7 if is_evening else 0.3
		
		if randf() < rain_chance:
			current_weather = "rain"
			$Timer.wait_time = randf_range(6, 10) if is_evening else randf_range(3, 6)
		else:
			$Timer.wait_time = randf_range(5, 10)
			
	elif current_weather == "rain":
		current_weather = "none"
		$Timer.wait_time = randf_range(8, 15)
	
	update_weather_visibility()
	$Timer.start()

func update_weather_visibility():
	var raining = (current_weather == "rain")
	
	$rain.visible = raining
	self.visible = raining

	if raining:
		start_rain_sfx()
	else:
		stop_rain_sfx()

func start_rain_sfx():
	rain_sfx.volume_db = -30
	rain_sfx.play()
	create_tween().tween_property(rain_sfx, "volume_db", 1, 1.5)

func stop_rain_sfx():
	var t = create_tween()
	t.tween_property(rain_sfx, "volume_db", -30, 1.5)
	t.finished.connect(func(): rain_sfx.stop())
