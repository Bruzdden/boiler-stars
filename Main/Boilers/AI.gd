extends CharacterBody2D

var speed = 100
var attacking = true

var p = 0

@onready var player = get_parent().get_node("Boiler")
@onready var navAgent : NavigationAgent2D = $NavigationAgent2D

var Boiler = Global.Save.Boilers[Global.boilerName[Global.Selected_enemy]]

var health = Boiler.max_health

var gem = 0


func _ready() -> void:
	for i in 3:
		Global.Save.Enemy["enemy"+str(i+1)].health = Boiler.max_health
	
	$Boiler/Skin.texture = Global.boilerSpriteSkin[Global.Selected_enemy]
	$Boiler/Skin.scale = Global.boilerSpriteScale[Global.Selected_enemy]
	$Boiler/Skin.position = Global.boilerSpritePosition[Global.Selected_enemy]
	$Boiler/Skin.rotation = Global.boilerSpriteRotation[Global.Selected_enemy]
	$BoilerUI/HealthUI/Label.text = str(Boiler.max_health)
	$BoilerUI/HealthUI/HealthBar.max_value = Boiler.max_health
	$BoilerUI/HealthUI/HealthBar.value = Boiler.max_health
	$BoilerUI/Name.text = str(Global.boilerName[Global.Selected_enemy])
	
	
	_make_path()
	
func _physics_process(delta : float)-> void:
	if gem > 0:
		$BoilerUI/Gem.show()
		$BoilerUI/Gem/Label.text = str(gem)
	#var dir = to_global(navAgent.get_next_path_position()).normalized()
	#velocity = dir * speed
	#move_and_slide()
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navAgent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()
	
	
	for i in 3:
		#var enemy = JSON.parse_string(Global.EntityList[i])
		if Global.Save.Enemy["enemy"+str(i+1)].health <= 0:
			Global.Save.Enemy["enemy"+str(i+1)].attacking = false
			Global.Save.Enemy["enemy"+str(i+1)].death = true
			self.hide()
			if $Timers/DeathTimer.is_stopped():
				$Timers/DeathTimer.start()
	
func _make_path() -> void:
	if Global.Player != null and attacking == true:
		navAgent.target_position = Global.Player.global_position
		print(navAgent.target_position)

func _on_timer_make_path_timeout():
	p = randi() % 10
	if p >= 5:
		_make_path()

func _damage(damage):
	for i in 3:
		#$BoilerUI/HealthUIHealthAnimation.play("AnimationDamage")
		if health > 0:
			var multiplier = 2 if Global.abilityMarksman else 1
			
			health -= damage * multiplier
			print(health)
		else:
			health = 0
		#$HealthBarUI/Damage.text = "-" + str(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage * Global.multiplier)
		$BoilerUI/HealthUI/Label.text = str(health)
		$BoilerUI/HealthUI/HealthBar.value = health

func _on_hitbox_area_entered(area):
	if area.is_in_group("Bullet"):
		_damage(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage)
		
	if area.is_in_group("Stomper"):
		_damage(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage_ability)
		print(_damage(Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]].damage_ability))
		
	if area.is_in_group("Gem"):
		gem += 1
		
func _on_death_timer_timeout():
	for i in 3:
		#var enemy = JSON.parse_string(Global.EntityList[i])
		Global.Save.Enemy["enemy"+str(i+1)].health = Boiler.max_health
		Global.Save.Enemy["enemy"+str(i+1)].death = false
		Global.Save.Enemy["enemy"+str(i+1)].attacking = true
	
	self.show()





