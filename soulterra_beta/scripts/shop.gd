extends StaticBody2D

func _ready():
	$shopmenu.visible = false

func _process(_delta):
	if $shopmenu.item1owned == true:
		$berry_seedpack.visible = true
	if $shopmenu.item2owned == true:
		print("seedtwo swaping")

func _on_area_2d_body_entered(body):
	if body.has_method("player_shop_method"):
		$shopmenu.visible = true
		$shopmenu.player_ref = body 
		
func _on_area_2d_body_exited(_body):
	$shopmenu.visible = false
