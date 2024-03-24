extends CharacterBody2D
class_name PlayerClass

@export var movement : VirtualJoystick
@export var aim : VirtualJoystick
@export var superAim : VirtualJoystick

@export var maxAmmo : int
@export var maxBarValue : int
@export var Bullet : PackedScene
@export var Slash : PackedScene
@export var Flower : PackedScene

#var Flower = preload("res://Main/Boilers/Attacks/Flower.tscn")

var bulletReady = true

#var healthAddAnimation = $UI/BoilerUI/HealthUI/Panel.shadow_size

var game_over = false

var Boiler = Global.Save.Boilers[Global.boilerName[Global.Save.Selected_boiler]]

var abilityDash = false

var stompAddHealth = 2000


var currentAmmo = 3
@onready var shootReadyTimer = $UI/BoilerUI/AmmoUI/ShootReadyTimer
@onready var regenerationTimer = $UI/BoilerUI/HealthUI/Regeneration
@onready var regenerationWait = $UI/BoilerUI/HealthUI/RegenerationWait
@onready var AimShow = $AimShow
@onready var dashTimer = $UI/BoilerUI/Abilities/DashTimer
@onready var stompTimer = $UI/BoilerUI/Abilities/StompTimer

var threeAmmo = [get_node("UI/BoilerUI/AmmoUI/Bar1"),get_node("UI/BoilerUI/AmmoUI/Bar2"),get_node("UI/BoilerUI/AmmoUI/Bar3")]
var zero = 0
var i = 0
var ammoReady = [true, true, true]
var move_vector := Vector2.ZERO
var health = Boiler.max_health
var regeneration = false


var gem = 0

#camera - -100, -1700, 1400, 1000

func _ready():
	Global.Player = self
	#healthAddAnimation = 10
	$Boiler/Skin.texture = Global.boilerSpriteSkin[Global.Save.Selected_boiler]
	$Boiler/Skin.scale = Global.boilerSpriteScale[Global.Save.Selected_boiler]
	$Boiler/Skin.position = Global.boilerSpritePosition[Global.Save.Selected_boiler]
	$Boiler/Skin.rotation = Global.boilerSpriteRotation[Global.Save.Selected_boiler]
	$UI/BoilerUI/HealthUI/Label.text = str(Boiler.max_health)
	$UI/BoilerUI/HealthUI/HealthBar.max_value = Boiler.max_health
	$UI/BoilerUI/HealthUI/HealthBar.value = Boiler.max_health
	$UI/BoilerUI/Name.text = str(Global.boilerName[Global.Save.Selected_boiler])
	
	$UI/BoilerUI/HealthUI/DamageScreen.hide()
	
	get_node("UI/BoilerUI/Abilities").get_node("Ability"+str(Boiler.type)).show()
	
	if Global.mode == 0:
		$UI/BoilerUI/Button_exit.show()
	else:
		$UI/BoilerUI/Button_exit.hide()

func _physics_process(delta):
		
	if gem > 0:
		$UI/BoilerUI/Gem.show()
		$UI/BoilerUI/Gem/Label.text = str(gem)
#	# Movement using the joystick output:
#	if joystickLeft and joystickLeft.is_pressed():
#		position += joystickLeft.get_output() * speed * delta
	# Movement using Input functions:
	move_vector = Vector2.ZERO
	move_vector.x = Input.get_axis("ui_left", "ui_right")
	move_vector.y = Input.get_axis("ui_up", "ui_down")
	#position += Global.move_vector * Global.playerSpeed * delta
	move_and_collide(move_vector * Boiler.speed * delta)

	if abilityDash:
		if dashTimer.is_stopped():
			dashTimer.start()
		position += Vector2(5,0).rotated($Boiler.rotation - 1.5) * Boiler.speed * delta

	# Rotation:
	if movement and movement.is_pressed:
		#$Boiler.rotation = lerp_angle($Boiler.rotation, movement.output.angle() - 30, delta * 4)
		$Boiler.rotation = movement.output.angle() - 4.7
		#$Boiler/Look.show()
		
	#elif not movement.is_pressed:
		#$Boiler/Look.hide()
	
	if bulletReady == true and $BulletTimer.is_stopped():
		if aim and aim.is_pressed:
			get_node("AimShow/AimPanel"+str(Global.Save.Selected_boiler+1)).show()
			#AimShow.rotation = lerp_angle(AimShow.rotation, aim.output.angle() - 1.5, delta)
			AimShow.rotation = aim.output.angle() - 1.5
			
			shootReadyTimer.start()
		elif not aim.is_pressed and not shootReadyTimer.is_stopped():
			get_node("AimShow/AimPanel"+str(Global.Save.Selected_boiler+1)).hide()
			if currentAmmo > 0:
				_ammo()
				_shoot()
				
					
				
			
			shootReadyTimer.stop()
		
		
	if currentAmmo < maxAmmo:
		_reload()
		
	if health < Boiler.max_health and regenerationWait.is_stopped():
		regenerationWait.start()
		
	
	if $UI/BoilerUI/HealthUI/HealthBar.value <= Boiler.max_health / 2:
		$UI/BoilerUI/HealthUI/HealthBar.tint_progress = Color(255,0,0)
	else:
		$UI/BoilerUI/HealthUI/HealthBar.tint_progress = Color(0,255,0)
	if $UI/BoilerUI/HealthUI/HealthBar.value <= 0:
		game_over = true
	$UI/BoilerUI/HealthUI/Label.text = str(health)
	$UI/BoilerUI/HealthUI/HealthBar.value = health
	

func _ammo():
	get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).tint_progress = Color("6e6e6e")
	if currentAmmo == 3:
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).value -= maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).max_value = maxBarValue
	if currentAmmo == 2:
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).value -= maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).value -= maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).max_value = maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).max_value = maxBarValue
	if currentAmmo == 1:
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+2)).value -= maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).value -= maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).value -= maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+2)).max_value = maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).max_value = maxBarValue
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo)).max_value = maxBarValue
	currentAmmo -= 1
	

func _regeneration():
	if health < Boiler.max_health and regenerationWait.is_stopped():
		regenerationWait.start()
		
func _on_regeneration_wait_timeout():
	regenerationTimer.start()

func _on_regeneration_timeout():
	$UI/BoilerUI/HealthUI/HealthBarAnimation.play("AddHealth")
	if health <= Boiler.max_health - 1000:
		health += 1000
	else:
		health += Boiler.max_health - health
		regenerationTimer.stop()
	
		
	
func _reload():
	get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).value += 0.5
	if get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).value >= get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).max_value:
		get_node("UI/BoilerUI/AmmoUI").get_node("Bar"+str(currentAmmo+1)).tint_progress = Color("b06a1d")
		currentAmmo += 1

func _damage():
	regenerationTimer.stop()

func _shoot():
	regenerationTimer.stop()
	if bulletReady == true and $BulletTimer.is_stopped():
		if Global.Save.Selected_boiler == 0:
			for i in Boiler.bullet_count:
				bulletReady = false
				$BulletTimer.start()
				var weaponInstance = Bullet.instantiate()
				weaponInstance.position = $Boiler.position
				var dir = Vector2(1,0).rotated(AimShow.rotation + 1.5)
				weaponInstance.linear_velocity = dir * Boiler.damage_speed
				weaponInstance.rotation = AimShow.rotation + 1.5
				add_child(weaponInstance)
		
		
		if Global.abilityMarksman:
			$UI/BoilerUI/Abilities/AbilityActivatedPanel.hide()
			$UI/BoilerUI/Abilities/AbilityActivatedAnimation.stop()
			Global.abilityMarksman = false
		
		if Global.Save.Selected_boiler == 1:
			var slash = Slash.instantiate()
			slash.position = AimShow.position
			var dir = Vector2(0,1).rotated(AimShow.rotation + 1.5)
			slash.linear_velocity = dir * Boiler.damage_speed
			slash.rotation = AimShow.rotation
			add_child(slash)
		
		if Global.Save.Selected_boiler == 2:
			var flower = Flower.instantiate()
			flower.position = AimShow.position
			flower.rotation = AimShow.rotation
			print(flower.rotation)
			print(AimShow.rotation)
			add_child(flower)



func _on_bullet_timer_timeout():
	bulletReady = true



#MARKSMAN ABILITY
func _on_ability_marksman_pressed():
	Global.abilityMarksman = true
	$UI/BoilerUI/Abilities/AbilityActivatedPanel.show()
	$UI/BoilerUI/Abilities/AbilityActivatedAnimation.play("AbilityActivated")

#ASSASSIN ABILITY
func _on_ability_assasin_pressed():
	_damage()
	health -= 2200
	abilityDash = true
	
func _on_dash_timer_timeout():
	abilityDash = false

#TANK ABILITY
func _on_ability_tank_pressed():
	Global.abilityTank = true
	$StompHitbox.show()
	$StompHitbox/CollisionShape2D.disabled = false
	stompTimer.start()
	if health <= Boiler.max_health - stompAddHealth:
		health += stompAddHealth
	else:
		health += Boiler.max_health - health

func _on_stomp_timer_timeout():
	Global.abilityTank = false
	$StompHitbox.hide()
	$StompHitbox/CollisionShape2D.disabled = true








func _on_hitbox_area_entered(area):
	if area.is_in_group("Gem"):
		gem += 1
		
