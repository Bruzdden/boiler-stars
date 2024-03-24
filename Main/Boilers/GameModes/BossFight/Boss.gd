extends RigidBody2D

@export var Bullet : PackedScene

@onready var player = get_parent().get_node("Boiler")

@onready var rangeAttackTimer = $AimShow/RangeAttackTimer
@onready var attackingTimer = $AttackingTimer

var health = 100000
var maxHealth = 100000
var halfHealth = health / 2

var attacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/HealthBarUI/HealthBar.max_value = maxHealth
	$UI/HealthBarUI/HealthBar.value = maxHealth
	$UI/HealthBarUI/HealthText.text = str(maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.Player != null and attacking == false:
		$Sprite2D.look_at(player.position)
		$AimShow.look_at(player.position)
		
		var dire = Vector2(1,0).rotated($AimShow.rotation)
		linear_velocity = dire * Global.Boss.speed
	else:
		linear_velocity = Vector2.ZERO

func _shoot():
	attackingTimer.start()
	attacking = true
	for i in Global.Boss.bullet_count:
		var weaponInstance = Bullet.instantiate()
		weaponInstance.global_position = global_position
		var dir = Vector2(1,0).rotated($AimShow.rotation + 1.5)
		weaponInstance.linear_velocity = dir * Global.Boss.damage_speed
		weaponInstance.rotation = $AimShow.rotation + 1.5
		add_child(weaponInstance)

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


func _on_range_attack_timer_timeout():
	_shoot()


func _on_range_attack_area_entered(area):
	if area.is_in_group("Player"):
		if rangeAttackTimer.is_stopped():
			_shoot()


func _on_close_attack_area_entered(area):
	if area.is_in_group("Player"):
		attackingTimer.start()
		attacking = true


func _on_attacking_timer_timeout():
	attacking = false
