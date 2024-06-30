extends Resource
class_name Recipe

@export var name: String
@export var id: String
@export_enum("Mill", "TeaPot", "TeaRoller", "BobaShaper", "BobaCooker") var stationType: String
@export var ingredient1: Item
@export var ingredient2: Item
@export var ingredient3: Item
@export var ingredient4: Item
@export var ingredient5: Item
@export var ingredient6: Item
