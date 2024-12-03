extends Node2D

class_name PathfindingComponent

@export var body : CharacterBody2D
@export var rays : Array[RayCast2D]
#an array representing the directions of vectors as units of 1
#every diagonal vector is normalized 
var directions : Array[Vector2] = [Vector2(0, 1), Vector2(1, 1), Vector2(1, 0), Vector2(1, -1), Vector2(0, -1), Vector2(-1, -1), Vector2(-1, 0), Vector2(-1, 1)] 
var dotProducts : Array[float]

var interests : Array[float]
var dangers: Array[float]
var badOffset : float = 5 #when an array collides this gets taken from the interest

var target : Vector2 = Vector2.ZERO
var vectorToPlayer : Vector2 = Vector2.ZERO 

var bestVector : Vector2
var contextMap : Array[float]
var highestContext

var speed : float = 100
var steeringForce : float = 1



func _ready() -> void:
	contextMap.resize(len(directions))
	dotProducts.resize(len(directions))
	dangers.resize(len(directions))
	print(dotProducts)
	#makes the interest array the size of the rays array and gives it all starting value of 1
	for i in range(len(rays)):
		interests.append(1)


func _input(event):
	if event.is_action_pressed("z"):
		pass

func _process(_delta) -> void:
	getTarget()
	if target:
		getInterests()
		bestVector = directions[getLargestIndex(contextMap)]
		
		
		body.velocity = (bestVector * Vector2(speed, speed))

		body.move_and_slide()

		print(contextMap)


func getTarget() -> void:
	target = get_global_mouse_position()
	
	getInterests()


func getInterests() -> void:
	
	if not target:
		return

	#get vector to target
	vectorToPlayer = body.global_position - target

	#gets the dot product between each direction and the vector
	for i in range(len(directions)):
		interests[i] = directions[i].dot(vectorToPlayer)
	
	#gets the dangerous directions
	for i in range(len(rays)):
		if rays[i].is_colliding():
			dangers[i] = 5
	
	#gets context map (interest - danger)
	for i in range(len(interests)):
		contextMap[i] = interests[i] - dangers[i]


func getLargestIndex(arr : Array[float]) -> int:
	
	var indexNumber : int = 0
	var higestNumber : float = -1000

	for i in range(len(arr)):
		if arr[i] > higestNumber:
			higestNumber = arr[i]
			indexNumber = i
	

	return indexNumber


	
