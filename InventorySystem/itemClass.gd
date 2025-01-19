extends Node2D

class_name Item

@export var itemName : String

@export var pickUpArea : Area2D
var canPickUp : bool 

@export var image : Sprite2D
@export var inventoryImage : CompressedTexture2D
var inInv : bool = false

@export var equiped : bool = false

func _ready():
	itemReady()
	pickUpArea.connect("body_entered", canPick)
	pickUpArea.connect("body_exited", cannotPick)

func _process(delta) -> void:
	if Input.is_action_just_pressed("pickUp"):
		pickUp()
	#if its in the invetory and not equiped it should be hidded and inactive
	if inInv and not equiped:
		hide()
	#if its equipde it should be shown and active
	elif equiped:
		itemProcess(delta)
		show()
	#just on the floor
	else:
		show()

	

#make this function instead of ready and process, this classes ready function overwrites the normal ready and process functions
func itemReady() -> void:
	pass

func itemProcess(_delta) -> void:
	pass


func canPick(body) -> void:
	if not body is Player:
		return

	canPickUp = true

func cannotPick(body) -> void:
	if not body is Player:
		return

	canPickUp = false


@onready var inventorySystem = get_node("/root/InventorySystem")
func pickUp() -> void:
	if not canPickUp:
		return
	
	if inInv:
		return

	var inventory = inventorySystem.inventory
	for i in range(len(inventory)):
		if inventory[i] == null:

			var autoEquip = inventorySystem.isEmpty()

			inventorySystem.inventory[i] = self
			inInv = true

			if autoEquip:
				inventorySystem.currentItem = inventorySystem.inventory[i]
				equiped = true
				#inventorySystem.updateUI()

			return
	
