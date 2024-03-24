extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame

func _damage():
	$DamageShow.start()
	$Damage.show()
	$AnimationPlayer.play("Damage")

func _on_damage_show_timeout():
	$Damage.hide()
