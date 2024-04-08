# Player
[HOME](README.md)
- Každý hráč může hrát jednu ze tří [postav](Postavy.md)
## Pohyb
- Tento kód je ve funcki [_process()](https://docs.godotengine.org/en/stable/tutorials/scripting/idle_and_physics_processing.html), která se automaticky volá každých 10 ms
- Za vektor se dají konkrétní hodnoty vstupu, kam míří [joystick](https://godotengine.org/asset-library/asset/1787)
- Funkce [move_and_collide()]() umožní hráčí se hýbat a kolidovat s okolím. Na vstupu funkce je daný vektor, rychlost vybrané [postavy](Postavy.md) a [delta](https://docs.godotengine.org/en/stable/tutorials/scripting/idle_and_physics_processing.html)
```gdscript
move_vector = Vector2.ZERO
move_vector.x = Input.get_axis("ui_left", "ui_right")
move_vector.y = Input.get_axis("ui_up", "ui_down")
move_and_collide(move_vector * Boiler.speed * delta)
```
## UI
- Díky UI je hra zajímavější
- Ve hře je UI jako: Život bar, bar nábojů, jméno postavy a kruh díky kterému postava nesplývá s okolím

![UI2](https://github.com/Bruzdden/boiler-stars/assets/76947123/e6bc6d4b-68c6-471d-a99f-9db999075d56)
## Kolize
- Díky kolizi hráč nechodí přes zdi a může také dostávat damage
- Hráč je na vstvě 2 a koliduje s objekty na vstvách 3 a 4 kde jsou zdi a nepřátelé

![Kolize](https://github.com/Bruzdden/boiler-stars/assets/76947123/50a572e3-19c7-4cc9-b162-11826c7cea9c)

