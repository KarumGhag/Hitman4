extends CharacterBody2D

class_name BulletClass

var fireDistance : float
var originPoint : Vector2
var distanceTravelled : float

var damage : float

func _ready() -> void:
	originPoint = global_position

func _process(_delta):
	distanceTravelled = global_position.distance_to(originPoint)
	if (fireDistance != 0) and distanceTravelled >= fireDistance:
		queue_free()
	move_and_slide()