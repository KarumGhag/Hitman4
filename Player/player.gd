extends CharacterBody2D

class_name Player

@export var speed : float = 550
@export var accel : float = 0.07

var direction : Vector2 = Vector2.ZERO

var steering : Vector2
var mass : float = 2

@export var holder : Node2D

@onready var inventorySystem = get_node("/root/InventorySystem")

func _ready() -> void:
	inventorySystem.player = self

func _process(_delta) -> void:
	direction = Input.get_vector("left", "right", "up", "down")

	direction = direction.normalized() * speed

	steering = (direction - velocity) / mass

	velocity += steering * accel


	look_at(get_global_mouse_position())

	move_and_slide()