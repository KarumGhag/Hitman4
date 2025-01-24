extends CPUParticles2D

class_name BulletTrail

var kill : bool = false
var timeLeft : float = 100

func _process(_delta) -> void:
	if kill:
		one_shot = true
		await wait(1)
		queue_free()
	



func wait(seconds : float) -> void:
	await get_tree().create_timer(seconds).timeout
		