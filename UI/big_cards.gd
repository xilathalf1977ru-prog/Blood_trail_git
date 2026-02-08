extends Control

var big_cards: Array[ColorRect]
const SELECT: Dictionary[String, int] = {
	GC.PLACE:		0,
	GC.Act.MY_INV:	0,
	GC.Act.TRADE:	0,
	GC.Act.INV:		1,
}
func _ready() -> void:
	EventBus.menu.connect(show_menu)
	EventBus.check_all_menus_closed.connect(on_check_all_menus_closed)
	EventBus.all_menus_close.connect(close_all_menus)
	big_cards = [$BigCard0, $BigCard1, $BigCard2]
func show_menu(data, context) -> void:
	visible = true
	var n: int = SELECT[context]
	if n == 0:
		for i in big_cards.size():
			big_cards[i].visible = false
			big_cards[i].get_node("Name").text = ""
			big_cards[i].clear_cards()
	if context in [GC.Act.INV, GC.Act.TRADE]:
		big_cards[0].visible = true
		#big_cards[0].setup(GameManager.player_ref.data.actions[0], context)
		big_cards[0].setup(GameManager.player_ref.data.inv, context)
		big_cards[1].visible = true
		big_cards[1].setup(data, context)
		return
	big_cards[n].visible = true
	big_cards[n].setup(data, context)
func on_check_all_menus_closed():
	if !big_cards[0].visible and !big_cards[1].visible and !big_cards[2].visible:
		visible = false
func close_all_menus():
	for i in big_cards.size():
		big_cards[i]._on_button_x_pressed()

func _on_big_card_0_inv_stack_clicked(item_stack: ItemStack, n: int) -> void:
	if big_cards[1].local_data:
		item_stack_transfer(item_stack, n, big_cards[0], big_cards[1])
func _on_big_card_1_inv_stack_clicked(item_stack: ItemStack, n: int) -> void:
	if big_cards[0].local_data:
		item_stack_transfer(item_stack, n,  big_cards[1], big_cards[0])
func _on_big_card_2_inv_stack_clicked(_item_stack: ItemStack) -> void:
	pass # Replace with function body.

func item_stack_transfer(item_stack, n, from_inv, to_inv):
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
	
	
	#from_inv.remove_item(item_stack)
	#to_inv.add_item(item_stack.duplicate_deep(2))
