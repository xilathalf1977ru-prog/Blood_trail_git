extends ColorRect

const CARD_SCENE: Object = preload("res://UI/card.tscn")
var path: VBoxContainer
var local_data: Resource = null
var local_context: String = ""
@warning_ignore("unused_signal")
signal inv_stack_clicked(item_stack: ItemStack)
func _ready() -> void:path = $ScrollContainer/CardContainer
func setup(data: Resource, context: String) -> void:
	clear_cards()
	local_data = data
	local_context = context
	if context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]:
		var items: Array[ItemStack] = data.real_inv
		for i in items.size():
			var card: TextureRect = CARD_SCENE.instantiate()
			card.setup(items[i], context)
			_setup_card_common(card, items[i])
		save_inv()
	elif context in [GC.PLACE]:
		for i in data.actions.size():
			var card: TextureRect = CARD_SCENE.instantiate()
			card.setup(data, data.actions.keys()[i])
			_setup_card_common(card, data)
	update_ui()
func add_item(item_stack: ItemStack, n: int):
	if path.has_node(item_stack.name):
		#path.add_item_quantity(item_stack, n, local_data.id)
		#pass
		var card = path.get_node(item_stack.name)
		
		var index = local_data.real_inv.find(item_stack)
		
		#card.setup_vis(item_stack, local_data.id)
		card.setup_vis(local_data.real_inv[index], local_data.id)
	else:
		var card: TextureRect = CARD_SCENE.instantiate()
		#local_data.real_inv.append(item_stack)
		#item_stack.quantity = n
		card.setup(item_stack, item_stack.type)
		_setup_card_common(card, item_stack)
		#pass
	save_inv()
func remove_item(item_stack: ItemStack, n: int):
	#var local_item_stack: Resource = path.get_node(item_stack.name).card_data
	var card = path.get_node(item_stack.name)
	#local_item_stack.quantity -= n
	
	#path.get_node(local_item_stack.name).setup_vis(local_item_stack, local_data.id)
	var index = local_data.real_inv.find(item_stack)
	card.setup_vis(local_data.real_inv[index], local_data.id)
	print(local_data.real_inv[index].quantity)
	if local_data.real_inv[index].quantity == 0:
		#pass
		clear_card(card)
		#local_data.real_inv.erase(local_item_stack)
	save_inv()
func _setup_card_common(card: TextureRect, res_data: Resource) -> void:
	card.item_stack_clicked.connect(_on_item_stack_clicked)
	card.item_stack_use.connect(use_item)
	path.setup_card_common(card, res_data, local_data.id)
func _on_button_x_pressed() -> void:
	visible = false
	local_data = null
	clear_cards()
	EventBus.check_all_menus_closed.emit()
func clear_cards():
	for card in path.get_children():
		clear_card(card)
func clear_card(card):
	if card.item_stack_clicked.is_connected(_on_item_stack_clicked):
		card.item_stack_clicked.disconnect(_on_item_stack_clicked)
	if card.item_stack_use.is_connected(use_item):
		card.item_stack_use.disconnect(use_item)
	card.queue_free()
func _on_button_transfer_pressed() -> void:
	for card in path.get_children():
		inv_stack_clicked.emit(card.card_data, card.card_data.quantity)
func _on_item_stack_clicked(item_stack: ItemStack):
	inv_stack_clicked.emit(item_stack, 1)
func save_inv():
	local_data.inventory.clear()
	for i in local_data.real_inv:
		local_data.inventory[i] = i.quantity
	GameManager.invs[local_data.id] = local_data.inventory
func save_inv_money(): pass
func update_ui():
	$ButtonTransfer.visible = local_context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]
	if local_context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]:
		$Name.text = TR.lc(local_data.name) + " $ " + str(local_data.money)
	elif local_context in [GC.PLACE]:
		$Name.text = TR.lc(local_data.name)
func use_item(item_stack: ItemStack, n: int):
	#if local_data.id != "player": return
	if item_stack.main_type == "EQUIP":
		path.get_node(item_stack.name).setup_vis(item_stack, local_data.id)
		ActionManager.handle_action(item_stack, GC.Act.EQUIP)
		return
	elif item_stack.main_type == "HEAL":
		EventBus.sfx.emit("drink")
		ActionManager.handle_action(item_stack, GC.Act.HEAL, n)
		if item_stack.transforms_to:
			add_item(item_stack.transforms_to, n)
	elif item_stack.main_type == "BONUS":
		EventBus.sfx.emit("drink")
		ActionManager.handle_action(item_stack, GC.Act.BONUS)
		if item_stack.transforms_to:
			add_item(item_stack.transforms_to, n)
	remove_item(item_stack, n)
