extends Camera2D

class_name Camera

@export_subgroup("Camera")
@export var leanScale : float = 0.1
@export var leanSmoothness : float = 30


func _process(delta):
	var directionToMouse : Vector2 = (get_global_mouse_position() - position).normalized()
	var distanceToMouse : float = get_global_mouse_position().distance_to(position)
	var lean = directionToMouse * distanceToMouse * leanScale
	offset = lerp(offset, lean, delta * leanSmoothness)

func shakeCam(shakeAmount) -> void:
	var rng = RandomNumberGenerator.new()
	
	var shake : Vector2 = Vector2(rng.randf_range(-shakeAmount, shakeAmount), rng.randf_range(-shakeAmount, shakeAmount))
	offset += shake