extends Node2D

class_name InvetoryClass

var inventory : Array[Item] = [null]

var currentItem : Item

var player : Player




@export_subgroup("UI")
@export var currentItemUI : Sprite2D
@export var nextItemUI : Sprite2D
@export var previousItemUI : Sprite2D

var itemShowers : Array[Sprite2D] = [currentItemUI, nextItemUI, previousItemUI]


func _ready():
	inventory.resize(10)
	for i in range(len(inventory)):
		if inventory[i] != null:
			currentItem = inventory[i]
			break
	
	for i in range(len(itemShowers)):
		print(itemShowers[i])

	
	
	

func _process(_delta) -> void:
	for i in range(len(inventory)):
		if inventory[i] != null:
			inventory[i].global_position = player.holder.global_position

	if Input.is_action_just_pressed("next"):
		currentItem = inventory[getNext()]
		updateUI()

	if Input.is_action_just_pressed("last"):
		currentItem = inventory[getPrevious()]
		updateUI()

	if currentItem:
		currentItem.equiped = true	


	for i in range(len(inventory)):
		if inventory[i] != null:
			if inventory[i] != currentItem:
				inventory[i].equiped = false




#loops over the inventory forwards until a value is found and sets that to the next value


func getNext() -> int:
	var i : int = getCurrent()

	#no items in inventory
	if i == -1:
		return -1

	while true:
		if i + 1 == len(inventory):
			i = 0
			if inventory[i] != null:
				break

		i += 1
		if inventory[i] != null:
			break
	
	return i

#same as above but backwards
func getPrevious() -> int:
	var i : int = getCurrent()


	#no items in inventory
	if i == -1:
		return -1

	while true:
		if i - 1 < 0:
			i = len(inventory) - 1
			if inventory[i] != null:
				break
			continue
		
		i -= 1
		if inventory[i] != null:
			break


	return i

func getCurrent() -> int:
	#goes over the list - if the current item is j and not null it returns j
	for j in range(len(inventory)):
		if inventory[j] == currentItem and currentItem != null:
			return j
	
	#if above doesnt happen it just returns the first non null item
	for j in range(len(inventory)):
		if inventory[j] != null:
			return j

	#there are no items
	return -1


func isEmpty() -> bool:
	for i in range(len(inventory)):
		if inventory[i] != null:
			return false
		
	return true





#called whenever current item changes
func updateUI() -> void:
	var current : int = getCurrent()
	#there are no items in the inventory so it should hide all items
	if current == -1:
		for i in range(len(itemShowers)):
			itemShowers[i].hide()
		return
	

	var next : int = getNext()
	var previous : int = getPrevious()
	currentItemUI.texture = inventory[current].image.texture

	#there is only 1 item in the inventory so it should hide
	if next == current:
		nextItemUI.hide()
		return
	else:
		nextItemUI.show()

	if previous == current:
		previousItemUI.hide()
		return
	else:
		nextItemUI.show()
	
	#shows all items

	print(inventory[next])
	nextItemUI.texture = inventory[next].image.texture
	previousItemUI.texture = inventory[previous].image.texture
