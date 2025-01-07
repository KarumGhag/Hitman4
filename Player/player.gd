extends CharacterBody2D

class_name Player

@export var speed : float = 550
@export var accel : float = 0.07

var direction : Vector2 = Vector2.ZERO

var steering : Vector2
var mass : float = 2


func _process(_delta) -> void:
	direction = Input.get_vector("left", "right", "up", "down")

	direction = direction.normalized() * speed

	#velocity.x = move_toward(velocity.x, direction.x, accel)
	#velocity.y = move_toward(velocity.y, direction.y, accel)

	steering = (direction - velocity) / mass

	velocity += steering * accel


	look_at(get_global_mouse_position())

	move_and_slide()