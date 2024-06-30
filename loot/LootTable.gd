extends Resource
class_name LootTable

class LootItem:
	var item: Item
	var rollCount: int
	var threshold: int

@export_group("Slot 1")
@export var item1: Item
@export_range(1, 100, 1) var rollCount1
@export_range(1, 100000, 1) var threshold1

@export_group("Slot 2")
@export var item2: Item
@export_range(1, 100, 1) var rollCount2
@export_range(1, 100000, 1) var threshold2
