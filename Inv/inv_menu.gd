extends ColorRect

@export var path: VBoxContainer
@onready var slots: Array[Panel] = []
var inv_data: Array

func _ready():
	for child in path.get_children():
		if child is Panel:
			slots.append(child)
			child.item_stack_del.connect(del_item)

func setup(data: Resource) -> void:
	$Name.text = TR.lc(data.name) + " $" + str(data.money)
	inv_data = data.real_inv
	for i in inv_data.size():
		slots[i].local_item_stack = null
		slots[i].setup_vis(data.player, inv_data[i])
func del_item(item_stack: ItemStack, n: int):
	ActionManager.reduce_item(inv_data, item_stack, n)
	var slot = path.get_node(item_stack.name)
	slot.setup_vis(true, item_stack)
