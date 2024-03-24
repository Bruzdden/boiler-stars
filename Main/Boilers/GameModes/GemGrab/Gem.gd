extends Area2D



func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		Global.gemCollected[1] += 1
		queue_free()
	if area.is_in_group("Player"):
		Global.gemCollected[0] += 1
		queue_free()
