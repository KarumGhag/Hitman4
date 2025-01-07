extends EnemyState

class_name ChaseState


#State managment

var player : Player
var targetOffset : Vector2
var offsetRange : int = 70

var offsetChangeTimer : Timer
@export var offsetTime : float = 5

func onEnter() -> void:
	player = body.player
	nav = body.nav
	if player == null:
		print_debug(str(self) + " has no player")
	

	#the target offset is a random vector added to the target to make different enemies have different targets
	newOffset()

	#creates a timer that runs out every 10 seconds to create a new target
	offsetChangeTimer = Timer.new()
	offsetChangeTimer.autostart = true
	offsetChangeTimer.one_shot = false
	add_child(offsetChangeTimer)
	offsetChangeTimer.connect("timeout", newOffset)
	offsetChangeTimer.start(offsetTime)

	

#removes the offset timer from the queue
func onExit() -> void:
	offsetChangeTimer.queue_free()

func newOffset() -> void:
	targetOffset = Vector2(randi_range(-offsetRange, offsetRange), randi_range(-offsetRange, offsetRange))


var speed : float = 300
var accel : float = 0.08

var steering : Vector2
var mass : float = 5

var nav : NavigationAgent2D
var direction : Vector2 = Vector2.ZERO

var velocity : Vector2
var global_position : Vector2

func state_process(_delta) -> void:
	global_position = body.global_position
	#gets where to go
	nav.target_position = getTarget()

	#normalized vector to move to to get the to target
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized() * speed

	#calc for steering smoothley
	steering = (direction - velocity) / mass
	velocity += steering * accel

	#basically move and slide()
	body.velocity = velocity

	


func getTarget() -> Vector2:
	return player.global_position + targetOffset


