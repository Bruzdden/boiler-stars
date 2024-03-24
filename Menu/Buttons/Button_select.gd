extends TextureButton


func _on_pressed():
	$Click.play()
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")
	if Global.firstBoilerSelected == false:
		Global.firstBoilerSelected = true
	#Global._save()
