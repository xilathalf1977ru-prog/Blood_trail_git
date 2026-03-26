extends Resource
class_name PlaceData

@export var name: String
@export var type: String  # "shop", "home", "forest"
@export var id: String = "none"
@export var icon: Texture2D

@export var sprites: SpriteFrames

#@export var actions: Array[ActionData]
@export var actions: Dictionary[String, Texture2D]

@export var dist: int

@export var inventory: Dictionary[ItemStack, int]
var real_inv: Array[ItemStack]
@export var money: int
@export var trade: bool

func _init() -> void:
	call_deferred("on_resource_init")
func on_resource_init() -> void:
	real_inv.clear()
	for i in inventory:
		var copy = i.duplicate()
		copy.quantity = inventory[i]
		real_inv.append(copy)
	
