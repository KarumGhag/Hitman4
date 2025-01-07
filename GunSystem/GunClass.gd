extends Node

class_name Gun

@export_group("Nodes")
@export var bullet : PackedScene

@export_group("Stats")
@export var fireCoolDown : float
var fireCoolDownTimer : Timer
var canShoot : bool = true
@export var fireDistance : float
@export var auto : bool
@export var spread : float
@export var shotgun : bool
@export var bulletsPerShot : int



func _ready() -> void:
	fireCoolDownTimer = Timer.new()
	fireCoolDownTimer.one_shot = true
	fireCoolDownTimer.autostart = false

	add_child(fireCoolDownTimer)


func _process(_delta) -> void:
	pass

func shootLocation() -> Vector2:
	var target : Vector2

	return target

func shoot() -> void:
	return