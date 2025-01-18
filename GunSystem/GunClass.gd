extends Item

class_name GunClass

@export_group("Nodes")
@export var bullet : PackedScene
@export var shootPoint : Node
@export var animationPlayer : AnimationPlayer

@export_group("Stats")
#basic gun stats
@export var auto : bool
@export var shotgun : bool

## Time between each shot
@export var fireCoolDown : float = 0.1
var fireCoolDownTimer : Timer
## How far the bullet goes before despawning
## If 0 it is until it hits a wall
@export var fireDistance : float
## How much the bullets can spread away from the mouse
@export var spread : float
## Amount of bullet shot per click
## Must be at least 1
@export var multiBulletNum : int = 1
## Only use if above is above 1
## After a bullet is shot it waits this much time for the next bullet to be shot
@export var multiBulletWait : float = 0.05
## How many times the bullet will bounce
@export var bulletBounces : int = 1

@export var damage : float
@export var bulletSpeed : float = 1000

@export_subgroup("reload")
## max bullets
@export var magSize : int = 16
var bulletsLeft : int
@export var reloadTime : float = 2
var reloadTimer : Timer
var canShoot : bool = true

var target : Vector2



@export_subgroup("Camera")
@export var shakeAmount : float = 5


func itemReady() -> void:
	bulletsLeft = magSize
	fireCoolDownTimer = Timer.new()
	fireCoolDownTimer.one_shot = true
	fireCoolDownTimer.autostart = false

	fireCoolDownTimer.connect("timeout", canShootAgain)

	add_child(fireCoolDownTimer)

func canShootAgain() -> void:
	canShoot = true

func itemProcess(_delta) -> void:
	look_at(get_global_mouse_position())
	if auto:
		if Input.is_action_pressed("shoot"):
			shoot()
	else:
		if Input.is_action_just_pressed("shoot"):
			shoot()

func shootLocation() -> Vector2:
	var innacuracy = randf_range(-spread, spread)
	target = Vector2.from_angle(shootPoint.global_position.angle_to_point(get_global_mouse_position()) + innacuracy)

	return target.normalized()

func shoot() -> void:


	if bulletsLeft <= 0:
		reload()
		return
	if not canShoot:
		return

	canShoot = false
	
	for i in range(multiBulletNum):
		if bulletsLeft <= 0:
			reload()
			break


		if animationPlayer != null:
			animationPlayer.play("Shoot")


		var bulletDirection : Vector2 = shootLocation()
		var bulletInstance = bullet.instantiate()
		bulletInstance.global_position = shootPoint.global_position
		#bulletInstance.velocity = bulletDirection * bulletSpeed
		bulletInstance.direction = bulletDirection

		bulletInstance.look_at(get_global_mouse_position())

		bulletInstance.fireDistance = fireDistance
		bulletInstance.damage = damage
		bulletInstance.bounces = bulletBounces
		bulletInstance.speed = bulletSpeed
		
		get_tree().get_root().add_child(bulletInstance)

		var camera : Camera = inventorySystem.camera
		camera.shakeCam(shakeAmount)
		
		if shotgun or multiBulletWait == 0:
			continue
		await wait(multiBulletWait)

	bulletsLeft -= 1
	fireCoolDownTimer.start(fireCoolDown)

func wait(seconds : float) -> void:
	await get_tree().create_timer(seconds).timeout

func reload() -> void:
	await wait(reloadTime)
	bulletsLeft = magSize
