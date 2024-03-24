extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Boiler.texture = Global.boilerSpriteSkin[Global.Save.Selected_boiler]
	$Boilers/TextureRect.texture = Global.boilerSpriteSkin[Global.Save.Selected_boiler]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.firstBoilerSelected == false:
		get_tree().change_scene_to_file("res://Menu/ChooseBoiler.tscn")


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Main/Boilers/GameModes/GemGrab/GemGrabMode.tscn")
	$Click.play()


func _on_boilers_pressed():
	get_tree().change_scene_to_file("res://Menu/ChooseBoiler.tscn")
	$Click.play()
