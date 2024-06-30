extends Node3D

@onready var spawn_sound: AudioStreamPlayer = $SpawnSound
@onready var loot_pool: Node3D = $LootPool

var spawnQueue: Array[Node3D]
var timeTilSpawn = 0.20
var spawnAt := Vector3.ZERO

var packedScenes = {}

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#for n in 4:
		#var item = taro.instantiate()
		#taro_set.push_back(item)
		#add_child(item)


func _process(delta: float) -> void:
	if spawnQueue.size() <= 0:
		return
	if timeTilSpawn <= 0:
		spawn_sound.play()
		var toSpawn = spawnQueue.pop_front()
		toSpawn.spawn(spawnAt)
		timeTilSpawn = 0.20
	else:
		timeTilSpawn -= delta

#func reportDeath(mob: String, global_pos: Vector3):
	#spawnsNeeded = taro_set.size() - 1
	#spawnAt = global_pos
	#for n in taro_set.size():
		#taro_set[n].spawn(global_pos)

func loadItem(item: Item):
	if item.id in packedScenes:
		return
	packedScenes[item.id] = load(item.lootableScene)

func getItem(item: Item):
	loadItem(item)
	var instance = packedScenes[item.id].instantiate()
	loot_pool.add_child(instance)
	return instance

func processLootSlot(item: Item, rollCount: int, threshold: int):
	for i in rollCount:
		var roll = randi_range(0,100000)
		if roll < threshold:
			var lootable = getItem(item)
			spawnQueue.push_back(lootable)

func generateLoot(lootTable: LootTable, pos: Vector3):
	spawnAt = pos
	processLootSlot(lootTable.item1, lootTable.rollCount1, lootTable.threshold1)

func reset():
	for n in loot_pool.get_children():
		n.queue_free()
