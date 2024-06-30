extends HBoxContainer

@onready var available: Label = $Available
@onready var needed: Label = $Needed
@onready var icon: TextureRect = $Icon
@onready var nameLabel: Label = $Name

var ingredient: Item

var canAfford = false

func _ready() -> void:
	populateElements()

func populateElements():
	if not ingredient: return
	if not icon: return
	var have = Inventory.itemCount(ingredient.id)
	var need = 1
	if have >= need: 
		canAfford = true
		set("theme_override_colors/font_color", Color.DARK_SEA_GREEN)
	else:
		set("theme_override_colors/font_color", Color.HOT_PINK)
	available.text = str(have)
	needed.text = str(need)
	icon.texture = ingredient.inventory_image
	nameLabel.text = ingredient.name
	
	
func setIngredient(item: Item):
	ingredient = item
	populateElements()
