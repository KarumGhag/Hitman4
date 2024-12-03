extends Node2D

class_name PathfindingComponent

@export var body : CharacterBody2D

@export var rays : Array[RayCast2D]
var directions : Array[Vector2] = [Vector2(0, -1), Vector2(1, -1), Vector2(1, 0), Vector2(1, -1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, 1)]

var target : Vector2
var localVector : Vector2

var interests : Array[float]
var contextMap : Array[float]
var dangers : Array[float]
var dangerSize : float = 5

var bestDirection : Vector2

var steeringForce : Vector2

func _ready():
	print(rays)
	for i in range(len(directions)):
		directions[i] = directions[i].normalized()
		interests.append(1)
		dangers.append(0)
		contextMap.append(0)


func getTarget() -> void:
	target = get_global_mouse_position()

	localVector = body.global_position - target
	localVector = localVector.normalized() 

func getInterests() -> void:
	for i in range(len(directions)):
		interests[i] = localVector.dot(directions[i])
		if rays[i].is_colliding():
			dangers[i] = dangerSize
		else:
			dangers[i] = 0
	
	for i in range(len(contextMap)):
		contextMap[i] =  dangers[i] - interests[i]
	

func getLargest() -> Vector2:
	var largest : float = -10000
	var index : int
	for i in range(len(contextMap)):
		if contextMap[i] > largest:
			largest = contextMap[i]
			index = i
	
	bestDirection = directions[index]
	return bestDirection

func _process(delta) -> void:
	getTarget()
	getInterests()

	steeringForce = (localVector - body.velocity).normalized() * 100
	body.velocity += getLargest() * delta * 1000
	body.move_and_slide()

	pass