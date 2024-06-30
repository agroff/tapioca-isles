extends Resource
class_name Item

@export var name: String
@export var id: String
@export var inventory_image: Texture
@export var recipe: Recipe
@export_file("*.tscn") var lootableScene
