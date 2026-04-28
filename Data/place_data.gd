extends Resource
class_name PlaceData

@export var name: String
@export var type: String
@export var id: String = "none"
@export var icon: Texture2D
@export var sprites: SpriteFrames

@export var actions: Dictionary[String, Texture2D]
@export var dist: int
@export var inventory: Dictionary[ItemStack, int]
#var real_inv: Array[ItemStack]
var real_inv2: Dictionary[String, ItemStack]
@export var money: int
@export var trade: bool

@export var entities: Array[EntityData]
@export var player: bool = false
@export var timed: bool = false
var ticks: int = 0

@export var transform_to: PlaceData = null
func _init() -> void:
	call_deferred("on_resource_init")
func on_resource_init() -> void:
	#real_inv.clear()
	real_inv2.clear()
	for i in inventory:
		var copy = i.duplicate()
		copy.quantity = inventory[i]
		#real_inv.append(copy)
		real_inv2[copy.name] = copy
func add_item(item: Resource, n: int):
	var key: String = item.name
	if real_inv2.has(key):
		real_inv2[key].quantity +=n#1
	else:
		real_inv2[key] = item
		real_inv2[key].quantity = n#1
func reduce_item(item: Resource, n: int):
	var key: String = item.name
	real_inv2[key].quantity -=n#1
	if real_inv2[key].quantity == 0:
		real_inv2.erase(key)
