extends Area2D

@export var itemRes:InventoryItems

func collect(inventory : Inventory):
	inventory.insert_items(itemRes)
	queue_free()
	
