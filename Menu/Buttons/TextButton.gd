extends Panel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().is_hovered():
		get_parent().scale = Vector2(1.015,1.015)
	else:
		get_parent().scale = Vector2(1,1)
		
