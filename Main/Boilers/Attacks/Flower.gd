extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Flower/FlowerLine1.hide()
	$Flower/FlowerLine2.hide()
	$Flower/FlowerLine3.hide()
	$Hitbox/CollisionPolygon2D1.hide()
	$Hitbox/CollisionPolygon2D2.hide()
	$Hitbox/CollisionPolygon2D3.hide()
	$Hitbox/CollisionPolygon2D1.disabled = true
	$Hitbox/CollisionPolygon2D2.disabled = true
	$Hitbox/CollisionPolygon2D3.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
