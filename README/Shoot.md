# Shoot
- Díky střílení hráč může bojovat s nepřáteli
## Ukázka kódu střílení
```gdscript
func _shoot():
	regenerationTimer.stop()
	if bulletReady == true and $BulletTimer.is_stopped():
		if Global.Save.Selected_boiler == 0:
			for i in Boiler.bullet_count:
				bulletReady = false
				$BulletTimer.start()
```
- Při výstřelu hráč spustí časovač, díky kterému není možné pořád střílet rychle dokola
```gdscript
				var weaponInstance = Bullet.instantiate()
				weaponInstance.position = $Boiler.position
				var dir = Vector2(1,0).rotated(AimShow.rotation + 1.5)
				weaponInstance.linear_velocity = dir * Boiler.damage_speed
				weaponInstance.rotation = AimShow.rotation + 1.5
				add_child(weaponInstance)
```
- Tato část slouží k vytvoření instance Bullet. Poté se určí její pozice a rotace, podle toho kam hráč míří. Ke konci se vypočítá trajektorie kam a jak rychle náboj poletí
## Ukázká kódu přebíjení
```gdscript
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
```
- Hráč má tří bary nábojů, když vystřelí, tím že pustí joystick, tak se odebere jeden bar ve funkci _ammo() a vystřelí ve funkci _shoot()
- Joystick ovládá rotaci postavy, kam míří a kdy vystřelí



