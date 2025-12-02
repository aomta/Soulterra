extends Node

var player_current_attack = false

var plantselected = 1 #corn = 1 #2 = tomato

var numofcorn = 0
var numoftomato = 0
var numofberry = 0

var coins = 0

var current_scene = "world" #world island side
var transition_scene = false

var player_exit_islandside_posx = 304
var player_exit_islandside_posy = 8
var player_start_posx = 65
var player_start_posy = 79

var game_first_loading = true

var weather

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "island_side"
		else:
			current_scene = "world"
	
