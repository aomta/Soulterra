extends Node2D

var state = "no apples" #no apples, apples
var player_in_area = false

var apple = preload("res://scenes/applecollectable.tscn")

@export var item: InvItem
var player = null 

func _ready():
	if state == "no apples":
		$growthtimer.start()
		
func _process(_delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no apples"
				drop_apple()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false


func _on_growthtimer_timeout() -> void:
	if state == "no apples":
		state = "apples"
		
func drop_apple():
	var apple_intance = apple.instantiate()
	apple_intance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_intance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growthtimer.start()
	
