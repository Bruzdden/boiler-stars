extends TextureButton




func _on_pressed():
	if Global.firstBoilerSelected == false:
		get_tree().change_scene_to_file("res://Menu/ChooseBoiler.tscn")
	else:
		get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")
