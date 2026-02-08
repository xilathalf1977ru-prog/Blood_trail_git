extends ColorRect

const START_X: int = 151
const START_Y: int = 181
const STEP_Y: int = 360
const CARD_SCENE: Object = preload("res://UI/card.tscn")
var path: HBoxContainer
var local_data: Resource = null
var local_context: String = ""
@warning_ignore("unused_signal")
signal inv_stack_clicked(item_stack: ItemStack)
@warning_ignore("unused_signal")
signal up_step_card(pos_y: int)
func _ready() -> void:path = $ScrollContainer/HBoxContainer
func setup(data: Resource, context: String) -> void:
	clear_cards()
	local_data = data
	local_context = context
	if context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]:
		var items: Array[ItemStack] = data.real_inv
		for i in items.size():
			var card: Sprite2D = CARD_SCENE.instantiate()
			card.setup(items[i], context)
			_setup_card_common(card, items[i], i)
			up_step_card.connect(card.on_up_step_card)
		save_inv()
	elif context in [GC.PLACE]:
		var items: Array[ActionData] = data.actions
		for i in items.size():
			var card: Sprite2D = CARD_SCENE.instantiate()
			card.setup(items[i], items[i].type)
			_setup_card_common(card, items[i], i)
	update_ui()
	
func add_item(item_stack: ItemStack, n: int):
	if path.has_node(item_stack.name):
		var local_item_stack: Resource = path.get_node(item_stack.name).card_data
		#local_item_stack.quantity += 1
		local_item_stack.quantity += n
		path.get_node(local_item_stack.name).setup_vis(local_item_stack, local_context)
	else:
		#item_stack.quantity = 1
		item_stack.quantity = n
		var card: Sprite2D = CARD_SCENE.instantiate()
		card.setup(item_stack, local_context)
		_setup_card_common(card, item_stack, local_data.real_inv.size())
		up_step_card.connect(card.on_up_step_card)
		local_data.real_inv.append(item_stack)
	save_inv()
func remove_item(item_stack: ItemStack, n: int):
	var local_item_stack: Resource = path.get_node(item_stack.name).card_data
	#local_item_stack.quantity -= 1
	
	local_item_stack.quantity -= n
	path.get_node(local_item_stack.name).setup_vis(local_item_stack, local_context)
	if local_item_stack.quantity == 0:
		up_step_card.emit(path.get_node(local_item_stack.name).position.y)
		clear_card(path.get_node(local_item_stack.name))
		local_data.real_inv.erase(local_item_stack)
	save_inv()
func _setup_card_common(card: Sprite2D, res_data, row_index: int) -> void:
	card.setup_vis(res_data, local_context)
	card.name = res_data.name
	card.item_stack_clicked.connect(_on_item_stack_clicked)
	_position_card(card, row_index)
	path.add_child(card)
func _position_card(card, row_index: int) -> void:
	card.position = Vector2(START_X, START_Y + row_index * STEP_Y)
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
	if up_step_card.is_connected(card.on_up_step_card):
		up_step_card.disconnect(card.on_up_step_card)
	card.queue_free()
	
func _on_button_transfer_pressed() -> void:
	for card in path.get_children():
		inv_stack_clicked.emit(card.card_data, card.card_data.quantity)
func _on_item_stack_clicked(item_stack: ItemStack):
	inv_stack_clicked.emit(item_stack, 1)
	#if item_stack.quantity < 3:
		#inv_stack_clicked.emit(item_stack, 1)
	#else:
		#print("MNERJ")
func save_inv():
	GameManager.invs[local_data.resource_path] = local_data.real_inv
func save_inv_money():
	GameManager.invs_money[local_data.resource_path] = local_data.money
func update_ui():
	$ButtonTransfer.visible = local_context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]
	if local_context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]:
		$Name.text = local_data.name + " $ " + str(local_data.money)
	elif local_context in [GC.PLACE]:
		$Name.text = local_data.name
