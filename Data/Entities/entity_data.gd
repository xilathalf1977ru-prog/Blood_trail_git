extends Resource

class_name EntityData  # ⭐ВАЖНО: даём имя классу!

var equip_slots: Array = []

@export var name: String
@export var icon: Texture2D
@export var id: String = "none"
@export var player: bool
@export var max_hp: int
@export var current_hp: int
#@export var food: int
@export var position: Vector2
@export var steps: int
#@export var attack_speed: int

@export var attack: int
@export var shield: int

@export var direction: Vector2
@export var actions: Array[ActionData]
@export var inv: ActionData
func _init() -> void:
	EventBus.resource_init.connect(on_resource_init)
func on_resource_init() -> void:
	for i in actions:
		i.owner_id = id
		if i.type in [GC.Act.INV, GC.Act.TRADE]:
			inv = i
