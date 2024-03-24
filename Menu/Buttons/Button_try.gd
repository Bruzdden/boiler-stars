extends TextureButton


func _on_pressed():
	$Click.play()
	get_tree().change_scene_to_file("res://Main/Practice/PracticeGame.tscn")
	
