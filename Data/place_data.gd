extends Resource
class_name PlaceData

@export var name: String
@export var type: String  # "shop", "home", "forest"
@export var icon: Texture2D
@export var actions: Array[ActionData]
@export var inv: ActionData

@export var heal_amount: int
@export var destination: int

func _init() -> void:
	EventBus.resource_init.connect(on_resource_init)
func on_resource_init() -> void:
	actions.append(inv)
	#print(inv.inventory)
