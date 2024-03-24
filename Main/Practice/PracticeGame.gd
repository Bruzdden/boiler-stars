extends Node2D


func _ready():
	Global.mode = 0
	
	var player = Global.boilerPlayer[0].instantiate()
	add_child(player)
	
