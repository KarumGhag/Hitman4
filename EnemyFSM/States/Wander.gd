extends EnemyState

class_name WanderState

var reachedTarget : bool = true

var pickDirTimer : Timer
var newDirTime : float = 5
@export var directionRay : RayCast2D

func onEnter() -> void:
	nav = body.nav
	player = body.player

	pickDirTimer = Timer.new()
	pickDirTimer.autostart = true
	pickDirTimer.one_shot = false
	pickDirTimer.wait_time = newDirTime
	pickDirTimer.start(newDirTime)

	add_child(pickDirTimer)

	pickDirTimer.connect("timeout", newDir)

	if direction == Vector2.ZERO:
		newDir()

func onExit() -> void:
	pickDirTimer.queue_free()

func state_process(delta) -> void:

	#calc for steering smoothley
	steering = (direction - velocity) / mass
	velocity += steering

	#basically move and slide()
	body.velocity = velocity

	print(pickDirTimer.time_left)

func newDir() -> void:
	direction = Vector2(randf_range(-10, 10), randf_range(-10, 10))
	direction = direction.normalized() * speed
