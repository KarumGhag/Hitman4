extends RayCast2D

class_name DangerRay

var noLongerDangerous : Timer

var maxTime = 0.5

func _ready() -> void:
	noLongerDangerous = Timer.new()
	noLongerDangerous.autostart = false
	noLongerDangerous.one_shot = true
	noLongerDangerous.wait_time = maxTime
	
	add_child(noLongerDangerous)
	noLongerDangerous.connect("timeout", timeout)

@export var pathFindingComponent : PathfindingComponent
@export_range(0, 7) var rayNum : int

func start() -> void:
	print(str(rayNum) + ": started")
	noLongerDangerous.start()


var timedOut : bool

func timeout() -> void:
	timedOut = true

	pathFindingComponent.dangers[rayNum] = 0
	print(pathFindingComponent.dangers[rayNum])

func _process(_delta) -> void:
	if is_colliding():
		noLongerDangerous.start()
		timedOut = false


	if noLongerDangerous.time_left == 0:
		pathFindingComponent.dangers[rayNum] = 0