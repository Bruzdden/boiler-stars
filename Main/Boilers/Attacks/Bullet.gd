extends RigidBody2D
class_name Bullet

var distance = 0

func _ready():
	pass

func _process(delta):
	distance += 1
	if distance == Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage_range:
		queue_free()

#damage_speed = 500 



func _on_body_entered(body):
	#if body is PracticeEnemy:
	#	Global._damage(body.health, Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage)
	queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()
