extends Panel

var item: ItemStack
signal item_transfer
signal item_del
func setup_vis(player: bool, item_stack: ItemStack) -> void:
	item = item_stack
	$TextureRect.texture = item_stack.icon
	name = item_stack.name
	$Name.text = TR.lc(item_stack.name) + " X" + str(item_stack.quantity)
	$Cost.text = "$" + str(item_stack.cost)
	if player:
		$ButtonExtra.set_extra_button(item_stack)
func _on_button_extra_pressed() -> void:
	if item.main_type == "EQUIP":
		ActionManager.handle_action(item, GC.Act.EQUIP)
		return
	elif item.main_type == "HEAL":
		EventBus.sfx.emit("drink")
		ActionManager.handle_action(item, GC.Act.HEAL, 1)
	elif item.main_type == "BONUS":
		EventBus.sfx.emit("drink")
		ActionManager.handle_action(item, GC.Act.BONUS)
	item_del.emit(item, 1)
func _on_button_pressed() -> void: 
	if item.quantity >= GC.QTY_LIMIT:
		var buffer: Array = []
		EventBus.show_quantity_menu.emit(true, item.quantity, buffer)
		EventBus.result_quantity_menu.connect(_on_result_quantity_menu)
	else:
		item_transfer.emit(item, 1)
func _on_result_quantity_menu(n: int, _buffer: Array) -> void:
	if n > 0:
		#print(n)
		item_transfer.emit(item, n)
	disconnect_quantity_menu()
func disconnect_quantity_menu():
	EventBus.show_quantity_menu.emit(false, 0, [])
	if EventBus.result_quantity_menu.is_connected(_on_result_quantity_menu):
		EventBus.result_quantity_menu.disconnect(_on_result_quantity_menu)
