extends Panel

@onready var quantity_label: Label = %QuantityLabel
@onready var name_label: Label = %NameLabel
@onready var icon: TextureRect = %Icon

var itemQuant: String = ""
var itemIcon: CompressedTexture2D = null
var itemName: String = ""

func _ready() -> void:
	print("inv item ready")
	quantity_label.text = str(itemQuant)
	name_label.text = itemName
	icon.texture =itemIcon

func setData(item: Item, quantity: int):
	itemQuant = str(quantity)
	itemIcon = item.inventory_image
	itemName = item.name
	print("data set: " + item.name + " - " + itemQuant)
	#quantity_label.text = str(quantity)
	#name_label.text = item.name
	#icon.texture = item.inventory_image
