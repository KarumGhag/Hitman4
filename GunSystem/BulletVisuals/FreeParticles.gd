extends CPUParticles2D

class_name FreeParticle

#frees a particle from queue

@export var timeAfterSpawn : float

func _ready() -> void:
    wait(timeAfterSpawn)

func wait(seconds : float) -> void:
    if timeAfterSpawn == null or timeAfterSpawn == 0:
        print_debug("No free time set!")

    await get_tree().create_timer(seconds).timeout

    queue_free()