# Boiler Stars
Lukáš Divíšek

- Gameplay z mé hry Boiler Stars která působí jako napodobenina mobilní hry Brawl Stars, jelikož tato hra je hodně populární a zajímává, tak jsem jí chtěl zkusit vytvořit.
- Bohužel se mi ke konci nepovedlo udělat Umělou inteligenci nepřátel a jejich životy. Chtěl jsem si to dát víc jako výzvu a nedělat všechno tak špagety a zkusit použít méně objektů a scriptů, to ale způsobilo problémy a nefunkčnost nepřátel. 
- V celku hra má být o tom, že si hráč vybere jednu ze tří postav, kterou si může vyzkoušet a potom vybrat.
- Hráč poté může hrát game mode jménem "GemGrab", kde je hráč proti třemi nepřátelům a každý se snaží jako první získat deset gemů. Když tým získá deset gemů, tak by se měli schovat a po patnácti sekundách, kdy tým drží všechny gemy, tak ten tým vyhrává.

## Ukázka kódu střílení
- Když si hráč vybere postavu číslo jedna, tak kód generuje náboje pomocí .instantiate(), náboji se určí pozice a přesná rotace, která způsobí jakým směrem se mění linear_velocity náboje. Takže v podstatě vystřelí.
```gdscript
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
```
## Ukázká kódu přebíjení
- Hráč má tří bary nábojů, když vystřelí, tím že pustí joystick, tak se odebere jeden bar ve funkci _ammo() a vystřelí ve funkci _shoot()
- Joystick ovládá rotaci postavy, kam míří a kdy vystřelí
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

## Výběr postav
- Hra začíná na obrazovce jménen "ChooseBoiler.tscn", kde jsou tří postavy v Sprite2D a mají každy tlačítka Try a Select.
![ChooseBoiler](https://github.com/Bruzdden/boiler-stars/assets/76947123/0e365166-e8a5-4e05-bd04-96c95c1c8c82)

## Tréninková mapa
- Tlačítko Try vás pošle na tréninkovou mapu kde si můžete vyzkoušet postavu, kterou chcete. V "PracticeGame.tscn" jsou tří boti do ktérých se dá útočit. Boti jsou nepohyblivý a mají svoje UI jako například životnost.
![PracticeGame](https://github.com/Bruzdden/boiler-stars/assets/76947123/18c2ea17-95a3-477d-b707-8e601d5fdaed)

## Hlavní menu
- Tlačítko Select vás pošle do "MainMenu.tscn", kde jsou tlčítka na vývěr postavu a start. V pozadí hraje hudba, kterou jsem vytvořil díky SunoAI.
![MainMenu](https://github.com/Bruzdden/boiler-stars/assets/76947123/8c13c7ed-60ce-404a-8c64-f4538937df9a)

## GemGrab
- Ve hče "GameGramMode.tscn" hrajete za postavu, kteoru jste si vybrali a poté se snažíte získat 10 gemů dřív než druhý tým. kdo má první deset gemů, tak se snaží schovat a po 15 sekundách vyhraje.
![GemGrab](https://github.com/Bruzdden/boiler-stars/assets/76947123/c4b7bf0d-db0e-4768-88f0-c4e42fb466a0)

## Hráč
- "Boiler.tscn" je hlavní instance kde je hráč. V této instanci jsou například pohyby díky joysticku. UI použítím CanvasLayeru. Střílecí funkce a tak dále.
![Boiler](https://github.com/Bruzdden/boiler-stars/assets/76947123/e56abb6e-7564-4532-be5e-fafebc8a0472)

## Pozadí
- Mapy jsou tvořeny TileMap.
- Jednoduchý Tileset jsem nakreslil sám pomocí webové aplikace [Piskell](https://www.piskelapp.com/)

## Assety
- Použil jsem Godot 4 asset joysticku. [Joystick](https://godotengine.org/asset-library/asset/1787)

## Audio
- Hudba v pozadí je vytvořena pomocí [Suno AI](https://www.suno.ai/)
- Zvuk kliknutí jsem nahrál přes audacity jako ťuk
  

[halo[(https://github.com/Bruzdden/boiler-stars/assets/76947123/4a313c68-6d4c-4603-b396-ce8178256d84)



## Video GamePlay
- [Video](https://youtu.be/s0drJbCHgkk)

# Autorem projektu je Lukáš Divíšek

