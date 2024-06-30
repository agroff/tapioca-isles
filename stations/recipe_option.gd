extends Panel

@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var label: Label = $VBoxContainer/Label
@onready var label_2: Label = $VBoxContainer/Label2

var item: Item
var recipePosition
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setData()

func setData():
	if not texture_rect: return
	if not item: return
	texture_rect.texture = item.inventory_image
	label.text = item.name
	label_2.text = recipePosition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setRecipeItem(itm: Item, index: int):
	item = itm
	recipePosition = str(index + 1)
	setData()
