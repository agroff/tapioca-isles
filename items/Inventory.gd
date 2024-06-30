extends Node

var items = {}
var quantities = {}

func getItems():
	var localItems = []
	for key in items:
		var item = items[key]
		print(item)
		localItems.push_back({
			"item": item,
			"quantity": quantities[item.id]
		})
	return localItems
	
func addItem(item: Item, quantity: int):
	if not item.id in items:
		items[item.id] = item
	if not item.id in quantities:
		quantities[item.id] = 0
	quantities[item.id] = quantities[item.id] + quantity

func itemCount(id: String):
	if not id in quantities:
		return 0
	return quantities[id]
