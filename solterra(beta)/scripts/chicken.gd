extends CharacterBody2D

var idle = false
var walking = false
var xdir = 1  # 1 == right, -1 == left
var ydir = 1  # 1 == down, -1 == up
var speed = 10
var _moving_vertical_horizontal = 1  # 1 = horizontal, 2 = vertical

func _ready():
	walking = true
	randomize()
	$changestatetimer.start()
	$walkingtimer.start()
	
func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if walking == true:
		$AnimatedSprite2D.play("walking")
		
		if _moving_vertical_horizontal == 1:  # Horizontal movement
			if xdir == -1:
				$AnimatedSprite2D.flip_h = true
			elif xdir == 1:
				$AnimatedSprite2D.flip_h = false
			velocity.x = speed * xdir
			velocity.y = 0
			
		elif _moving_vertical_horizontal == 2:  # Vertical movement
			velocity.y = speed * ydir
			velocity.x = 0
	
	elif idle == true:
		$AnimatedSprite2D.play("idle")
		velocity = Vector2.ZERO
		
	move_and_slide()

func _on_changestatetimer_timeout() -> void:
	var waittime = 1.0
	
	if walking == true:
		idle = true
		walking = false
		waittime = randf_range(1.0, 5.0)
	elif idle == true:
		walking = true
		idle = false
		waittime = randf_range(2.0, 6.0)
		
	$changestatetimer.wait_time = waittime
	$changestatetimer.start()

func _on_walkingtimer_timeout() -> void:
	var x = randf_range(1.0, 2.0)
	var y = randf_range(1.0, 2.0)
	var vh = randf_range(1.0, 2.0)
	var waittime = randf_range(1.0, 4.0)
	
	# Random direction horizontal
	if x > 1.5:
		xdir = 1  # right
	else:
		xdir = -1  # left
	
	# Random direction vertical
	if y > 1.5:
		ydir = 1  # down
	else:
		ydir = -1  # up
	
	# Random horizontal or vertical movement
	if vh > 1.5:
		_moving_vertical_horizontal = 1  # horizontal
	else:
		_moving_vertical_horizontal = 2  # vertical
	
	$walkingtimer.wait_time = waittime
	$walkingtimer.start()
