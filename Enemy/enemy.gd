extends CharacterBody2D

class_name Enemy

@export var nav : NavigationAgent2D
@export var player : Player

@export var lineOFSight : RayCast2D

@export var toRotate : Node2D

func _process(_delta) -> void:
	lineOFSight.target_position.x = getLOSVector().x
	lineOFSight.target_position.y = getLOSVector().y

	toRotate.look_at(player.global_position)

	move_and_slide()

func getLOSVector() -> Vector2:
	
	var target : Vector2 = player.global_position
	var yDiff : float = target.y - global_position.y
	var xDiff : float = target.x - global_position.x

	var xyDiff : Vector2 = Vector2(xDiff, yDiff)

	return xyDiff
