extends RigidBody2D
class_name PracticeEnemy

var health = 10000
var maxHealth = 10000
var halfHealth = health / 2
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/HealthBarUI/HealthBar.max_value = maxHealth
	$UI/HealthBarUI/HealthBar.value = maxHealth
	$UI/HealthBarUI/HealthText.text = str(maxHealth)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $UI/HealthBarUI/HealthBar.value <= halfHealth:
		$UI/HealthBarUI/HealthBar.tint_progress = Color(255,0,0)
		$UI/HealthBarUI/HealthBar.value = health
	if $UI/HealthBarUI/HealthBar.value <= 0:
		$".".queue_free()

	

func _on_timer_timeout():
	#$UI/HealthBar.value -= 1000
	#Healt -= 1000
	pass

func _damage(damage):
	$UI/HealthBarUI/HealthAnimation.play("AnimationDamage")
	$UI/HealthBarUI._damage()
	if health > 0:
		var multiplier = 2 if Global.abilityMarksman else 1
		health -= damage * multiplier
	else:
		health = 0
	$UI/HealthBarUI/Damage.text = "-" + str(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage * Global.multiplier)
	$UI/HealthBarUI/HealthText.text = str(health)
	$UI/HealthBarUI/HealthBar.value = health


func _on_hitbox_area_entered(area):
	if area.is_in_group("Bullet"):
		_damage(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage)
		
	if area.is_in_group("Stomper"):
		_damage(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage_ability)
		print(_damage(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage_ability))
