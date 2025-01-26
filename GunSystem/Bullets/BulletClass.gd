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
var bulletTrail : CPUParticles2D

@export var impact : PackedScene

var knockback : float

func _ready() -> void:
	originPoint = global_position
	hitbox.connect("body_entered", hitBoxBody)
	hitbox.connect("area_entered", hitBoxArea)
	
	velocity = speed * direction

func _process(_delta) -> void:
	distanceTravelled = global_position.distance_to(originPoint)
	if (fireDistance != 0) and distanceTravelled >= fireDistance:
		killParticles()
		queue_free()

	if bulletTrail != null:
		bulletTrail.position = global_position

	move_and_slide()


	#Doesnt work fully - might remove bounces from bullets

	#var collision = move_and_collide(velocity * delta)
	#if collision and bounces > 0:
	#	print("bounce")
	#	velocity = velocity.bounce(collision.get_normal())
	#	bounces -= 1

	
	


func hitBoxBody(body) -> void:
	
	var tempVel : Vector2 = velocity
	velocity = Vector2.ZERO
	print(velocity)
	if body is BulletClass:
		velocity = tempVel
		return

	
	killParticles()
	queue_free()

func hitBoxArea(area) -> void:
	if area is HitBoxComponent:
		killParticles()

		var attack : Attack = Attack.new()

		attack.damage = damage
		attack.knockback = knockback
		attack.attackPos = global_position

		area.damage(attack)
		

		
		queue_free()
	
func killParticles() -> void:
	if impact != null:
		var impactInst = impact.instantiate()
		impactInst.emitting = true
		impactInst.global_position = global_position
		impactInst.direction = -direction
		get_tree().get_root().add_child(impactInst)

	if bulletTrail != null:
		bulletTrail.kill = true

