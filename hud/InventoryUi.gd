extends Panel

@export var inv_item: PackedScene
@onready var inv_item_container: GridContainer = %InvItemContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.

func updateInventory() -> void:
	var items = Inventory.getItems()
	
	for n in inv_item_container.get_children():
		inv_item_container.remove_child(n)
		n.queue_free()
	
	for item in items:
		var itemNode = inv_item.instantiate()
		print(item)
		itemNode.setData(item.item, item.quantity)
		inv_item_container.add_child(itemNode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		if visible:
			hide()
		else:
			updateInventory()
			show()
