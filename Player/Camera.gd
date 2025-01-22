extends Camera2D

class_name Camera

@export_subgroup("Camera")
@export var heldLean : float = 0.1
@export var unheldLean : float = 0.06


@export var leanSmoothness : float = 30
@export var player : Player

var maxDist : int = 150

var mousePos : Vector2
var directionToMouse : Vector2
var distanceToMouse : float

var lean : Vector2

func _process(delta):
	#camera will only lean if the player is holding an item
	
	mousePos = get_viewport().get_mouse_position()

	directionToMouse = (mousePos - position).normalized()
	distanceToMouse = mousePos.distance_to(position)

	if player.inventorySystem.currentItem != null:
		lean = directionToMouse * distanceToMouse * heldLean
	else:
		lean = directionToMouse * distanceToMouse * unheldLean
	
	offset = lerp(offset, lean, delta * leanSmoothness)


	distanceToMouse = clamp(distanceToMouse, 0, maxDist)


func shakeCam(shakeAmount) -> void:
	var rng = RandomNumberGenerator.new()
	
	var shake : Vector2 = Vector2(rng.randf_range(-shakeAmount, shakeAmount), rng.randf_range(-shakeAmount, shakeAmount))
	offset += shake
