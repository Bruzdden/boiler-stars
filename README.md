# Boiler Stars
Lukáš Divíšek

- Gameplay z mé hry Boiler Stars která působí jako napodobenina mobilní hry Brawl Stars, jelikož tato hra je hodně populární a zajímává, tak jsem jí chtěl zkusit vytvořit.
- Bohužel se mi ke konci nepovedlo udělat Umělou inteligenci nepřátel a jejich životy. Chtěl jsem si to dát víc jako výzvu a nedělat všechno tak špagety a zkusit použít méně objektů a scriptů, to ale způsobilo problémy a nefunkčnost nepřátel. 
- V celku hra má být o tom, že si hráč vybere jednu ze tří postav, kterou si může vyzkoušet a potom vybrat.
- Hráč poté může hrát game mode jménem "GemGrab", kde je hráč proti třemi nepřátelům a každý se snaží jako první získat deset gemů. Když tým získá deset gemů, tak by se měli schovat a po patnácti sekundách, kdy tým drží všechny gemy, tak ten tým vyhrává.

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

## Další
- Mapy jsou tvořeny TileMap.
- Hudbu jsem vytvořil díky SunoAi, které jste doporučil v hodině (teda ukázal vam to Karel). Ve hře je také zvuk kliknutí, který jsem udělal sám. Zkoušel jsem dělat další zvuky jako například chození v trávě, ale v přírodě je přiroda a nemám bohužel kvalitní mikrofon a další jsem nestíhal.
- Použil jsem Godot 4 asset joysticku [joystick](https://godotengine.org/asset-library/asset/1787)


## YT video GamePlay z hry
[Video](https://youtu.be/s0drJbCHgkk)

Celý projekt jsem dělal sám.

## Lukáš Divíšek



 
