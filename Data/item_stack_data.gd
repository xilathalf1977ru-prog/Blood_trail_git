extends Resource
class_name ItemStack

@export var item: ItemData
var quantity: int = 1

var name: String:
	get:
		return item.name
var type: String:
	get:
		return item.type
var main_type: String:
	get:
		return item.main_type

#var editor_main_type: int:
	#get:
		#return item.editor_main_type
#var EditorType:
	#get:
		#return item.EditorType
var sprites: SpriteFrames:
	get:
		return item.sprites


var equip_type: String:
	get:
		return item.equip_type
var equip_bonus: Dictionary:
	get:
		return item.equip_bonus
var single_bonus: Dictionary:
	get:
		return item.single_bonus

var cost: int:
	get:
		return item.cost
var icon: Texture2D:
	get:
		return item.icon
var heal_amount: int:
	get:
		return item.heal_amount
var transforms_to: ItemStack:
	get:
		return item.transforms_to





#@export var durability: float = 1.0  # ← добавь если нужно
#@export var quality: int = 1         # ← добавь если нужно
#func can_merge_with(other: ItemStack) -> bool:
	#return item == other.item 
	##and durability == other.durability # ← раскомментируй когда добавишь
	##and quality == other.quality		# ← раскомментируй когда добавишь
#
#func merge(other: ItemStack) -> void:
	#if can_merge_with(other):
		#quantity += other.quantity
#
#func dupl() -> ItemStack:
	#var new_stack = ItemStack.new()
	#new_stack.item = item
	#new_stack.quantity = quantity
	## new_stack.durability = durability  # ← раскомментируй когда добавишь
	## new_stack.quality = quality        # ← раскомментируй когда добавишь
	#return new_stack
