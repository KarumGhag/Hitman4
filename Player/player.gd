extends CharacterBody2D

class_name Player

@export var speed : float = 550
@export var accel : float = 35

var direction : Vector2 = Vector2.ZERO

func _process(_delta) -> void:
	direction = Input.get_vector("left", "right", "up", "down")

	direction = direction.normalized()

	velocity.x = move_toward(velocity.x, direction.x * speed, accel)
	velocity.y = move_toward(velocity.y, direction.y * speed, accel)
	
	look_at(get_global_mouse_position())

	move_and_slide()