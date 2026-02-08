extends Resource
class_name ItemStack


@export var item: ItemData
@export var quantity: int = 1

var name: String:
	get:
		return item.name if item else ""
var type: String:
	get:
		return item.type if item else ""
var cost: int:
	get:
		return item.cost if item else 0
var icon: Texture2D:
	get:
		return item.icon if item else null
#@export var durability: float = 1.0  # ← добавь если нужно
#@export var quality: int = 1         # ← добавь если нужно


func can_merge_with(other: ItemStack) -> bool:
	return item == other.item 
	#and durability == other.durability # ← раскомментируй когда добавишь
	#and quality == other.quality		# ← раскомментируй когда добавишь

func merge(other: ItemStack) -> void:
	if can_merge_with(other):
		quantity += other.quantity

func dupl() -> ItemStack:
	var new_stack = ItemStack.new()
	new_stack.item = item
	new_stack.quantity = quantity
	# new_stack.durability = durability  # ← раскомментируй когда добавишь
	# new_stack.quality = quality        # ← раскомментируй когда добавишь
	return new_stack
