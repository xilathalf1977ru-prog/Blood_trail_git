extends Resource
class_name ActionData

@export var name: String
@export var type: String
@export var icon: Texture2D
@export var heal_amount: int
@export var money: int
@export var menu: bool
@export var dist: int

var owner_id: String

@export var inventory: Dictionary[ItemStack, int]
var real_inv: Array[ItemStack]
func _init() -> void:
	EventBus.resource_init.connect(on_resource_init)
func on_resource_init() -> void:
	real_inv.clear()
	for i in inventory:
		var copy = i.duplicate()
		copy.quantity = inventory[i]
		real_inv.append(copy)
		
	#real_inv = inventory.duplicate_deep(1)
	
