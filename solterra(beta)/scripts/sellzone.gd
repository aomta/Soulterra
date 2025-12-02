extends StaticBody2D


func _on_area_2d_body_entered(body):
	if body.has_method("player_sell_method"):
		var corn = Global.numofcorn
		var tomato = Global.numoftomato
		var coins = Global.coins 
		
		#corn = 2 tomato = 4
		
		coins += corn * 50
		coins += tomato * 50
		
		corn = 0
		tomato = 0
		
		Global.coins = coins
		Global.numofcorn = corn
		Global.numoftomato = tomato  
