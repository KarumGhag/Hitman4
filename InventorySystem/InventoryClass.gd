extends Node2D

class_name InvetoryClass

var inventory : Array[Item] = [null]

var currentItem : Item

func _ready():
	inventory.resize(10)
	for i in range(len(inventory)):
		if inventory[i] != null:
			currentItem = inventory[i]
			break

	print(inventory)

func _process(_delta) -> void:

	if Input.is_action_just_pressed("next"):
		currentItem = getNext()
	if Input.is_action_just_pressed("last"):
		currentItem = getPrevious()


	if currentItem:
		currentItem.equiped = true	


		
#loops over the inventory forwards until a value is found and sets that to the next value
func getNext() -> Item:
	var i : int = getCurrent()
	
	if i == -1:
		print("no items")
		print(inventory)
		return

	while true:
		if i + 1 >= len(inventory):
			i = 0
			if inventory[0] != null:
				break
			continue

		i += 1

		if inventory[i] != null:
			break

	return inventory[i]

#same as above but backwards
func getPrevious() -> Item:
	var i : int = getCurrent()

	if i == -1:
		print("no items")
		print(inventory)
		return

	while true:
		if i - 1 < 0:
			i = len(inventory) - 1
			if inventory[i] != null:
				break
			continue
		
		i -= 1
		if inventory[i] != null:
			break

	return inventory[i]

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
