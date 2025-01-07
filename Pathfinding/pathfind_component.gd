extends Node2D

class_name PathfindingComponent

@export var body : CharacterBody2D

@export var rays : Array[DangerRay]
var directions : Array[Vector2] = [Vector2(0, -1), Vector2(1, -1), Vector2(1, 0), Vector2(1, -1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, 1)]

var target : Vector2
var localVector : Vector2

var interests : Array[float]
var contextMap : Array[float]
var dangers : Array[float]
var dangerSize : float = -5

var bestDirection : Vector2

var steeringForce : Vector2


@export var navigationAgent : NavigationAgent2D

func _ready():
	print(rays)
	for i in range(len(directions)):
		directions[i] = directions[i].normalized()
		interests.append(1)
		dangers.append(0)
		contextMap.append(0)


func getTarget() -> void:
	navigationAgent.target_position = get_global_mouse_position()
	target = navigationAgent.get_next_path_position()

	localVector = body.global_position - target
	localVector = localVector.normalized() 

func getInterests() -> void:
	for i in range(len(directions)):
		interests[i] = localVector.dot(directions[i])
		if rays[i].is_colliding():
			dangers[i] = dangerSize

			if i + 1 == 8:
				dangers[0] = dangerSize
				#dangers[i - 1] = dangerSize
			
			elif i - 1 == -1:
				dangers[7] = dangerSize
				#dangers[i + 1] = dangerSize

			else:
				dangers[i + 1] = dangerSize
				#dangers[i - 1] = dangerSize

		else:
			#rays[i].start()
			pass


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

@export var label : Label

func _process(_delta) -> void:
	
	getTarget()
	getInterests()

	steeringForce = (getLargest() - body.velocity).normalized() * 100
	body.velocity += getLargest() * 5
	body.velocity = body.velocity.clamp(Vector2(-100, -100), Vector2(100, 100))
	body.move_and_slide()



	var timesLeft : Array[float]
	timesLeft.resize(7)
	for i in range(len(rays) - 1):
		timesLeft[i] = rays[i].noLongerDangerous.time_left
		
	if label != null:
		label.text = "Danger: " + str(dangers) + "\nContext: " + str(contextMap) + "\nBest direction: " + str(getLargest()) + "\nTimers: " + str(timesLeft)


	#print(timesLeft)
