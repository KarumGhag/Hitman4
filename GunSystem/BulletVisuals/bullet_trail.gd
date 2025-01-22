extends CPUParticles2D

class_name BulletTrail

var fading : bool = false
var timeLeft : float = 100

func _process(_delta) -> void:
	if fading:
		one_shot = true
	
	#print(emitting)
		