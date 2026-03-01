extends Control

const SELECT: Dictionary[String, int] = {
	GC.PLACE:		0,
	GC.Act.MY_INV:	0,
	GC.Act.TRADE:	0,
	GC.Act.INV:		1,
}
const QUANTITY_MENU_THRESHOLD: int = 3
var big_cards: Array[ColorRect]
func _ready() -> void:
	EventBus.menu.connect(show_menu)
	EventBus.check_all_menus_closed.connect(on_check_all_menus_closed)
	EventBus.all_menus_close.connect(close_all_menus)
	big_cards = [$BigCard0, $BigCard1, $BigCard2]
func show_menu(data: Resource, context: String) -> void:
	visible = true
	var n: int = SELECT[context]
	if n == 0:
		for i in big_cards.size():
			big_cards[i].visible = false
			big_cards[i].get_node("Name").text = ""
			big_cards[i].clear_cards()
			
	if context in [GC.Act.INV, GC.Act.TRADE]:
		print(context)
		big_cards[0].visible = true
		big_cards[0].setup(GameManager.player_ref.data.inv, context)
		big_cards[1].visible = true
		big_cards[1].setup(data, context)
		return
	big_cards[n].visible = true
	big_cards[n].setup(data, context)
func on_check_all_menus_closed() -> void:
	if !big_cards[0].visible and !big_cards[1].visible and !big_cards[2].visible:
		visible = false
func close_all_menus() -> void:
	for i in big_cards.size():
		big_cards[i]._on_button_x_pressed()
	disconnect_quantity_menu()
func _on_big_card_0_inv_stack_clicked(item_stack: ItemStack, n: int) -> void:
	if big_cards[1].local_data and big_cards[1].visible:
		check_item_stack_transfer(item_stack, n, big_cards[0], big_cards[1])
func _on_big_card_1_inv_stack_clicked(item_stack: ItemStack, n: int) -> void:
	if big_cards[0].local_data and big_cards[0].visible:
		check_item_stack_transfer(item_stack, n,  big_cards[1], big_cards[0])
func _on_big_card_2_inv_stack_clicked(_item_stack: ItemStack, _n: int) -> void:
	pass
func check_item_stack_transfer(item_stack: ItemStack, n: int, 
from_inv: Object, to_inv: Object) -> void:
	if n == 1 and item_stack.quantity > QUANTITY_MENU_THRESHOLD:
		var buffer: Array = [item_stack, from_inv, to_inv]
		EventBus.show_quantity_menu.emit(true, item_stack.quantity, buffer)
		EventBus.result_quantity_menu.connect(_on_result_quantity_menu)
		return
	item_stack_transfer(item_stack, n, from_inv, to_inv)
func item_stack_transfer(item_stack: ItemStack, n: int, 
from_inv: Object, to_inv: Object) -> void:
	if (from_inv.local_data.type == "trade" 
	or to_inv.local_data.type == "trade"):
		if to_inv.local_data.money < item_stack.cost * n:
			return
		from_inv.local_data.money += item_stack.cost * n
		to_inv.local_data.money -= item_stack.cost * n
		from_inv.update_ui()
		to_inv.update_ui()
		from_inv.save_inv_money()
		to_inv.save_inv_money()
		
	to_inv.add_item(item_stack.duplicate(), n)
	from_inv.remove_item(item_stack, n)
func _on_result_quantity_menu(n: int, buffer: Array) -> void:
	if n > 0:
		item_stack_transfer(buffer[0], n, buffer[1], buffer[2])
	disconnect_quantity_menu()
func disconnect_quantity_menu():
	EventBus.show_quantity_menu.emit(false, 0, [])
	if EventBus.result_quantity_menu.is_connected(_on_result_quantity_menu):
		EventBus.result_quantity_menu.disconnect(_on_result_quantity_menu)
