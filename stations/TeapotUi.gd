extends Control

@export var recipes: Array[Item]
@export var recipeOptionScene: PackedScene
@export var ingredientItemScene: PackedScene

@onready var recipe_item_container: HBoxContainer = $RecipeSelect/MarginContainer/RecipeItemContainer
@onready var ingredient_container: GridContainer = $SingleRecipe/MarginContainer/VBoxContainer/IngredientContainer


@onready var recipe_select: Panel = $RecipeSelect
@onready var single_recipe: Panel = $SingleRecipe
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var recipe_finished: Panel = $RecipeFinished

@onready var finished_icon: TextureRect = $RecipeFinished/VBoxContainer/FinishedIcon
@onready var finished_name: Label = $RecipeFinished/VBoxContainer/FinishedName


var selected_recipe: Item
var cooking := false
var finished := false

func setInitialState():
	print("setting initial state")
	recipe_select.show()
	single_recipe.hide()
	progress_bar.hide()
	progress_bar.value = 0
	recipe_finished.hide()
	selected_recipe = null
	finished = false
	
	print("done with initial state")

func clearChildren(node: Node) -> void:
	for n in node.get_children():
		n.queue_free()

func populateRecipeList():
	var i = 0
	for recipe in recipes:
		var option = recipeOptionScene.instantiate()
		option.setRecipeItem(recipe, i)
		recipe_item_container.add_child(option)
		i += 1

func populateIngredients():
	clearChildren(ingredient_container)
	finished_icon.texture = selected_recipe.inventory_image
	finished_name.text = selected_recipe.name
	var recipe = selected_recipe.recipe
	var ingredients = []
	if recipe.ingredient1: ingredients.push_back(recipe.ingredient1)
	if recipe.ingredient2: ingredients.push_back(recipe.ingredient2)
	if recipe.ingredient3: ingredients.push_back(recipe.ingredient3)
	if recipe.ingredient4: ingredients.push_back(recipe.ingredient4)
	if recipe.ingredient5: ingredients.push_back(recipe.ingredient5)
	if recipe.ingredient6: ingredients.push_back(recipe.ingredient6)
	for ing in ingredients:
		var ingredient = ingredientItemScene.instantiate()
		ingredient.setIngredient(ing)
		ingredient_container.add_child(ingredient)

func _ready() -> void:
	hide()
	setInitialState()
	clearChildren(recipe_item_container)
	populateRecipeList()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if cooking:
		progress_bar.value = progress_bar.value + (delta * 10)
	if cooking and progress_bar.value >= 100:
		cooking = false
		finished = true
		progress_bar.hide()
		recipe_finished.show()
	# Only process input when in range 
	if not visible:
		return
		
	if Input.is_action_just_released("menu_item_1"):
		selectRecipe(0)
	if Input.is_action_just_released("menu_item_2"):
		selectRecipe(1)
	if Input.is_action_just_released("menu_item_3"):
		selectRecipe(2)
	if Input.is_action_just_released("menu_item_4"):
		selectRecipe(3)
	if single_recipe.visible and Input.is_action_just_pressed("attack"):
		single_recipe.hide()
		progress_bar.show()
		cooking = true
	if finished && Input.is_action_just_pressed("attack"):
		print("adding recipe to inventory")
		Inventory.addItem(selected_recipe, 1)
		setInitialState()

func selectRecipe(index: int):
	if index not in range(recipes.size()):
		# TODO: Play error sound 
		return
	selected_recipe = recipes[index]
	recipe_select.hide()
	single_recipe.show()
	populateIngredients()
	
	
