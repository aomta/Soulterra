extends CharacterBody2D

@onready var footstep_sfx = $FootstepSFX

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false

var step_timer := 0.0
var step_interval := 0.5    # makin kecil = makin cepat langkah

var speed = 50
var last_dir = Vector2.DOWN   # default menghadap bawah

@export var inv: Inv

func _physics_process(_delta):
	enemy_attack()
	attack()
	update_health()
	
	# jangan gerak atau ganti animasi kalau sedang attack
	if attack_ip:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		self.queue_free()
	
	velocity = Vector2.ZERO 
	
	var moved = false

	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		$AnimatedSprite2D.play("rightwalk")
		last_dir = Vector2.RIGHT
		moved = true

	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("leftwalk")
		last_dir = Vector2.LEFT
		moved = true

	elif Input.is_action_pressed("move_down"):
		velocity.y = speed
		$AnimatedSprite2D.play("downwalk")
		last_dir = Vector2.DOWN
		moved = true

	elif Input.is_action_pressed("move_up"):
		velocity.y = -speed
		$AnimatedSprite2D.play("upwalk")
		last_dir = Vector2.UP
		moved = true

	# Player berhenti ➜ arah idle mengikuti last_dir
	if !moved:
		play_idle_direction()
		step_timer = 0  # reset supaya tidak bunyi saat mulai jalan
	else:
		_process_footstep(_delta)

	move_and_slide()

func player():
	pass
	
func collect(item):
	inv.insert(item)
	
func player_sell_method():
	pass

func player_shop_method():
	pass

func play_idle_direction():
	# hentikan footstep langsung
	footstep_sfx.stop()
	step_timer = 0

	if last_dir == Vector2.RIGHT:
		$AnimatedSprite2D.play("idle_right")
	elif last_dir == Vector2.LEFT:
		$AnimatedSprite2D.play("idle_left")
	elif last_dir == Vector2.UP:
		$AnimatedSprite2D.play("idle_back")
	elif last_dir == Vector2.DOWN:
		$AnimatedSprite2D.play("idle")

func _process_footstep(delta):
	step_timer -= delta
	if step_timer <= 0:
		play_footstep()
		step_timer = step_interval

func play_footstep():
	footstep_sfx.pitch_scale = randf_range(0.9, 1.1)
	footstep_sfx.play()


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	if Input.is_action_just_pressed("attack") and !attack_ip:
		attack_ip = true
		Global.player_current_attack = true

		if last_dir == Vector2.RIGHT:
			$AnimatedSprite2D.play("swordright")

		elif last_dir == Vector2.LEFT:
			$AnimatedSprite2D.play("swordleft")

		elif last_dir == Vector2.DOWN:
			$AnimatedSprite2D.play("swordfront")

		elif last_dir == Vector2.UP:
			$AnimatedSprite2D.play("swordback")

		$deal_attack_timer.start()



func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false


func update_health():
	var healthbar = $CanvasLayer/uihealth/healthbar
	healthbar.value = health
	


func _on_regen_timer_timeout() -> void:
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
