extends Resource

class_name EntityData  # ⭐ВАЖНО: даём имя классу!

var equip_slots: Dictionary = {}

@export var name: String
@export var icon: Texture2D
@export var sprites: SpriteFrames
@export var id: String = "none"
@export var player: bool
@export var max_hp: int
@export var current_hp: int
@export var position: Vector2
@export var spawn_chance: float = 1.0
@export var steps: int
@export var damage: int
@export var armor: int
@export var direction: Vector2


@export var inventory: Dictionary[ItemStack, int]
var real_inv: Array[ItemStack]
@export var money: int
@export var trade: bool

func _init() -> void:
	call_deferred("on_resource_init")
func on_resource_init() -> void:
	real_inv.clear()
	for i in inventory:
		var copy: Resource = i.duplicate()
		copy.quantity = inventory[i]
		#real_inv.append(copy.duplicate())
		real_inv.append(copy)
