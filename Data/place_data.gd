extends Resource
class_name PlaceData

@export var name: String
@export var type: String  # "shop", "home", "forest"
@export var id: String = "none"
@export var icon: Texture2D

@export var actions: Array[ActionData]
@export var inv: ActionData

func _init() -> void:
	EventBus.resource_init.connect(on_resource_init)
func on_resource_init() -> void:
	for i in actions:
		i.owner_id = id
		if i.type in [GC.Act.INV, GC.Act.TRADE, GC.LOOT]:
			inv = i
			#print(inv)
