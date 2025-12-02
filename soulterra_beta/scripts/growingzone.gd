extends StaticBody2D
var plant = Global.plantselected
var plantgrowing = false
var plant_grown = false

func _physics_process(_delta):
	if plantgrowing == false:
		plant = Global.plantselected

func _on_area_2d_area_entered(_area):
	# ambil parent (StaticBody2D seedpack)
	var seed = _area.get_parent()

	# cek apakah ini seedpack
	if seed.name != "tomato_seedpack" and seed.name != "corn_seedpack":
		return
	if not plantgrowing:
		if plant == 1:
			plantgrowing = true
			$corngrowingtimer.start()
			$plant.play("corngrowing")
		if plant == 2:
			plantgrowing = true
			$tomatogrowingtimer.start()
			$plant.play("tomatogrowing")
	else:
		print("Plant already growing here")

func _on_corngrowingtimer_timeout():
	var corn_plant = $plant
	if corn_plant.frame == 0:
		corn_plant.frame = 1
		$corngrowingtimer.start()
	elif corn_plant.frame == 1:
		corn_plant.frame = 2
		$corngrowingtimer.start()
	elif corn_plant.frame == 2:
		corn_plant.frame = 3
		$corngrowingtimer.start()
	elif corn_plant.frame == 3:
		plant_grown = true

func _on_tomatogrowingtimer_timeout():
	var tomato_plant = $plant
	if tomato_plant.frame == 0:
		tomato_plant.frame = 1
		$tomatogrowingtimer.start()
	elif tomato_plant.frame == 1:
		tomato_plant.frame = 2
		$tomatogrowingtimer.start()
	elif tomato_plant.frame == 2:
		tomato_plant.frame = 3
		$tomatogrowingtimer.start()
	elif tomato_plant.frame == 3:
		plant_grown = true

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		if plant_grown:
			if plant == 1:
				Global.numofcorn += 1
				plantgrowing = false
				plant_grown = false
				$plant.play("none")
			elif plant == 2:
				Global.numoftomato += 1
				plantgrowing = false
				plant_grown = false
				$plant.play("none")
		print("number of corn: " + str(Global.numofcorn))
		print("number of tomato: " + str(Global.numoftomato))
