extends StaticBody2D

var item = 1 

var item1price = 100
var item2price = 300

var item1owned = false
var item2owned = false

var price

@onready var buy_sfx = $BuySFX    # ← tambahkan ini

func _ready():
	$icon.play("berryseed")
	item = 1

func _physics_process(_delta):
	if self.visible == true:
		if item == 1:
			$icon.play("berryseed")
			$pricelabel.text = "100"
			if Global.coins >= item1price:
				if item1owned == false:
					$buybuttoncolor.color = "24c500dc"
				else:
					$buybuttoncolor.color = "e2002bdc"
			else:
				$buybuttoncolor.color = "e2002bdc"

		if item == 2:
			$icon.play("seedtwo")
			$pricelabel.text = "300"
			if Global.coins >= item2price:
				if item2owned == false:
					$buybuttoncolor.color = "24c500dc"
				else:
					$buybuttoncolor.color = "e2002bdc"
			else:
				$buybuttoncolor.color = "e2002bdc"

func _on_buttonleft_pressed() -> void:
	swap_item_back()

func _on_buttonright_pressed() -> void:
	swap_item_forward()

func _on_buybutton_pressed() -> void:
	if item == 1:
		price = item1price
		if Global.coins >= price:
			if item1owned == false:
				buy()

	elif item == 2:
		price = item2price
		if Global.coins >= price:
			if item2owned == false:
				buy()

func swap_item_back():
	if item == 1:
		item = 2
	elif item == 2:
		item = 1

func swap_item_forward():
	if item == 1:
		item = 2
	elif item == 2:
		item = 1

func buy():
	Global.coins -= price

	# 🔊 MAINKAN SFX BELI
	if buy_sfx.playing:
		buy_sfx.stop()   # cegah numpuk
	buy_sfx.play()

	# tandai item sudah dibeli
	if item == 1:
		item1owned = true
	elif item == 2:
		item2owned = true
