extends Control

@export var menus: Array[ColorRect]
func _ready() -> void:
	EventBus.inv.connect(show_inv)
func show_inv(_context: String, arr_res: Array):
	for i in arr_res.size():
		menus[i].data = arr_res[i]
		menus[i].inv_data = arr_res[i].real_inv2
		menus[i].setup()
		menus[i].visible = true
		menus[i].get_node("Name").text = (TR.lc(arr_res[i].name) 
		+ " $" + str(arr_res[i].money))
	visible = true
func _on_button_exit_pressed() -> void:
	visible = false
	for i in menus.size():
		menus[i].clear()
		menus[i].visible = false
func _on_inv_menu_0_transfer(item_stack: ItemStack, n: int) -> void:
	if menus[1].visible:
		item_stack_transfer(item_stack, n, menus[0], menus[1])
func _on_inv_menu_1_transfer(item_stack: ItemStack, n: int) -> void:
	if menus[0].visible:
		item_stack_transfer(item_stack, n, menus[1], menus[0])
func item_stack_transfer(item_stack: ItemStack, n: int, 
from_inv: Object, to_inv: Object) -> void:
	if from_inv.data.trade or to_inv.data.trade:
		if to_inv.data.money < item_stack.cost * n:
			return
		from_inv.data.money += item_stack.cost * n
		to_inv.data.money -= item_stack.cost * n
		from_inv.get_node("Name").text = (TR.lc(from_inv.data.name) 
		+ " $" + str(from_inv.data.money))
		to_inv.get_node("Name").text = (TR.lc(to_inv.data.name) 
		+ " $" + str(to_inv.data.money))
	if (item_stack.main_type == "EQUIP" and item_stack.quantity == n
	and from_inv.data.player):
		EventBus.check_equip.emit(item_stack)
	from_inv.reduce_item(item_stack, n)
	to_inv.add_item(item_stack.duplicate(), n)
	EventBus.sfx.emit("drop")
