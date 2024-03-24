extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in 3:
		if get_node("boilers/Boiler"+str(i+1)).get_node("Button_select").is_pressed():
			Global.Save.Selected_boiler = i
		if get_node("boilers/Boiler"+str(i+1)).get_node("Button_try").is_pressed():
			Global.Save.Selected_boiler = i
