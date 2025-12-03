extends StaticBody2D

@onready var sell_sfx = $Sell_SFX

func _on_area_2d_body_entered(body):
	# Pastikan yang masuk player
	if body.has_method("player_sell_method"):
		
		var total_pendapatan = 0
		
		if Global.numofcorn > 0:
			total_pendapatan += Global.numofcorn * 50
			Global.numofcorn = 0
			print("Jagung terjual!")
			
		if Global.numoftomato > 0:
			total_pendapatan += Global.numoftomato * 50
			Global.numoftomato = 0
			print("Tomat terjual!")
			
		if body.inv != null:
			var inventory = body.inv
			var berry_terjual = false
			
			for slot in inventory.slots:
				if slot.item != null:
					if slot.item.name == "Berry" or slot.item.name == "berry":
						total_pendapatan += slot.amount * 60
						slot.item = null
						slot.amount = 0
						berry_terjual = true
			
			if berry_terjual:
				inventory.update.emit()
				Global.numofberry = 0
				print("Berry terjual dan dihapus dari tas!")

		if total_pendapatan > 0:
			Global.coins += total_pendapatan
			print("Total Uang Didapat: " + str(total_pendapatan))

			if sell_sfx != null: 
				if sell_sfx.playing:
					sell_sfx.stop() 
				sell_sfx.play()
