extends Node2D

#var enemies = []
# Called when the node enters the scene tree for the first time.

@export var gem : PackedScene

var Boiler = Global.Save.Boilers[Global.boilerName[Global.Selected_enemy]]

func _ready():
	Global.mode = 1
	
	var player = Global.boilerPlayer[0].instantiate()
	player.position = $Spawn/AllySpawn1.position + Vector2(40,40)
	add_child(player)
	
	for i in range(3):
		Global.EntityList.append(
			{
				"id": i,
				"position": get_node("Spawn/EnemySpawn" + str(i + 1)).position,
				"attacking": true,
				"health": Boiler.max_health,
				"isAlive": true
			}
		)
		Global.Selected_enemy = i
		Global.Save.Enemy["enemy"+str(i+1)].id = i
		var enemy = Global.enemy.instantiate()
		enemy.position = Global.EntityList[i].position
		add_child(enemy)
		Global.enemies.append(enemy)
		print(Global.enemies)
		
		
	print(Global.EntityList)
	Global.Selected_enemy = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(len(Global.enemies)):
		if Global.Save.Enemy["enemy"+str(i+1)].death == true:
			Global.enemies[i].position = get_node("Spawn/EnemySpawn" + str(i + 1)).position


func _on_gem_spawn_timer_timeout():
	var gemInstance = gem.instantiate()
	gemInstance.position = $GemSpawner/GemSpawnerPanel.position + Vector2(40,40)
	add_child(gemInstance)
