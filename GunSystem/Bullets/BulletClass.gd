extends CharacterBody2D

class_name BulletClass

var fireDistance : float
var originPoint : Vector2
var distanceTravelled : float

var damage : float

@export var hitbox : Area2D
#1 means it cannot bounce
var bounces : int = 1

var speed : float
var direction : Vector2

@export var selfCollider : CollisionShape2D

func _ready() -> void:
	originPoint = global_position
	hitbox.connect("body_entered", hitBoxBody)
	
	velocity = speed * direction

func _process(_delta) -> void:
	distanceTravelled = global_position.distance_to(originPoint)
	if (fireDistance != 0) and distanceTravelled >= fireDistance:
		queue_free()


	

	#Doesnt work fully - might remove bounces from bullets

	#var collision = move_and_collide(velocity * delta)
	#if collision and bounces > 0:
	#	print("bounce")
	#	velocity = velocity.bounce(collision.get_normal())
	#	bounces -= 1


	move_and_slide()
	
	


func hitBoxBody(body) -> void:
	if body == self:
		return
	
	if bounces == 0:
		queue_free()
		return
