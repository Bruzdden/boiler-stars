extends Node


var firstBoilerSelected = false

var boilerName = ["Kelly", "Nox", "Rass"]
var boilerClass = ["Marksman", "Assassin", "Tank"]
var boilerSpriteSkin = [load("res://Src/Kelly.png"), load("res://Src/noxangy.png"), load("res://Src/Rass.png")]
var boilerSpriteScale = [Vector2(0.12,0.12),Vector2(0.12,0.12), Vector2(0.12,0.12)]
var boilerSpritePosition = [Vector2(-3,-17),Vector2(-3,-17),Vector2(-3,-17)]
var boilerSpriteRotation = [0.5,0.5, 0.5]
var boilerPlayer = [load("res://Main/Boilers/Boiler.tscn")]

var boss = load("res://Main/GameModes/BossFight/Boss.tscn")
var enemy = load("res://Main/Boilers/AI.tscn")
var gem = load("res://Main/Boilers/GameModes/GemGrab/Gem.tscn")
var Player = null

var Bullet : PackedScene = load("res://Main/Boilers/Bullet.tscn")

var attackList = [preload("res://Main/Boilers/Attacks/Bullet.tscn"), preload("res://Main/Boilers/Attacks/Slash.tscn"), preload("res://Main/Boilers/Attacks/Flower.tscn")]

var playerRotation = 0
var aimingDirection = 0.0
var shootRequested = false

var abilityMarksman = false
var multiplier = 2 if abilityMarksman else 1

var abilityTank = false
var stomper = 2000 if abilityTank else 0

var mode = 0

var Selected_enemy = 0
var enemyNumber = 0
var enemyDeath = [false, false, false]

var enemies = []
var allies = []


var EntityList = []

var gemCollected = [0,0]

var Boss = {
	"healt" : 100000,
	"health_max" : 100000,
	"speed" : 50,
	"damage" : 1000,
	"damage_speed" : 400,
	"damage_range" : 50,
	"bullet_count" : 1,
}

var Save = {
	"Boilers" : {
		"Kelly" : {
			"max_health" : 2500,
			"health" : 2500,
			"speed" : 135,
			"damage" : 2500,
			"damage_ability" : 1000,
			"damage_speed" : 500,
			"damage_size" : Vector2(48, 384),
			"damage_range" : 50,
			"super_range" : 8,
			"reload" : 1,
			"bullet_count" : 1,
			"super_reload" : null,
			"type" : "Marksman",
		},
		"Nox" : {
			"max_health" : 4000,
			"health" : 4000,
			"speed" : 150,
			"damage" : 2000,
			"damage_ability" : 1000,
			"damage_speed" : 750,
			"damage_size" : Vector2(48, 384),
			"damage_range" : 12,
			"super_range" : 8,
			"reload" : 1,
			"bullet_count" : 1,
			"super_reload" : null,
			"type" : "Assassin",
		},
		"Rass" : {
			"max_health" : 7500,
			"health" : 7500,
			"speed" : 120,
			"damage" : 1500,
			"damage_ability" : 1000,
			"damage_speed" : 500,
			"damage_size" : Vector2(48, 384),
			"damage_range" : 30,
			"super_range" : 8,
			"reload" : 1,
			"bullet_count" : 1,
			"super_reload" : null,
			"type" : "Tank",
		},
	},
	"Enemy" : {
		"enemy1" : {
			"id" : 0,
			"death" : false,
			"health" : 0,
			"attacking" : true,
		},
		"enemy2" : {
			"id" : 1,
			"death" : false,
			"health" : 0,
			"attacking" : true,
		},
		"enemy3" : {
			"id" : 1,
			"death" : false,
			"health" : 0,
			"attacking" : true,
		},
	},
	"Selected_boiler" : 0,
	"Money" : 0,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _instance_node(node, location, rotation):
	var node_instance = node.instantiate()
	add_child(node_instance)
	node_instance.global_position = location
	node_instance.rotation = rotation
	return node_instance
	

func _set_aim_direction(direction):
	aimingDirection = direction
	
func _request_shoot():
	shootRequested = true
	

	
