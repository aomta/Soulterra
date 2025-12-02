extends Node2D

func _physics_process(_delta):
	$UI/corntext.text = ("= " + str(Global.numofcorn))
	$UI/tomatotext.text = ("= " + str(Global.numoftomato))
	
	$UI/cointext.text = ("= " + str(Global.coins))

func _ready():
	if Global.game_first_loading == true:
		$Game/player.position.x = Global.player_start_posx
		$Game/player.position.y = Global.player_start_posy
	else:
		$Game/player.position.x = Global.player_exit_islandside_posx
		$Game/player.position.y = Global.player_exit_islandside_posy


func _process(_delta):
	change_scenes()

func _on_islandside_transition_point_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


#func _on_islandside_transition_point_body_exited(body):
	#if body.has_method("player"):
		#Global.transition_scene = false
		
func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/island_side.tscn")
			Global.game_first_loading = false
			Global.finish_changescenes()
