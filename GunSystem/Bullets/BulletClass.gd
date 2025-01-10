extends CharacterBody2D

class_name BulletClass

var fireDistance : float
var originPoint : Vector2
var distanceTravelled : float

var damage : float

@export var hitBox : Area2D
#1 means it cannot bounce
var bounces : int = 1

func _ready() -> void:
	originPoint = global_position
	hitBox.connect("body_entered", hitBoxBody)

func _process(_delta):
	distanceTravelled = global_position.distance_to(originPoint)
	if (fireDistance != 0) and distanceTravelled >= fireDistance:
		queue_free()
	move_and_slide()
	look_at(get_global_mouse_position())


func hitBoxBody(body) -> void:
	bounces -= 1
	if bounces <= 0:
		queue_free()
		return


	velocity = -velocity
