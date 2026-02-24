extends TextureRect

const QUANTITY_MENU_THRESHOLD: int = 3
var context: String
var card_data: Resource

@warning_ignore("unused_signal")
signal item_stack_clicked(item_stack: ItemStack)
@warning_ignore("unused_signal")
signal item_stack_delete(item_stack: ItemStack)
@warning_ignore("unused_signal")
signal item_stack_create(item_stack: ItemStack)
func setup(data: Resource, type: String):
	card_data = data
	context = type
	if data is EntityData:setup_entity(data as EntityData)
	elif data is PlaceData:setup_place(data as PlaceData)
	if name != "CardPlayer" and name != "CardEntity" and $Name.text:
		name = $Name.text
	if data.icon:
		$TextureRect.texture = data.icon
func setup_entity(entity: EntityData):
	$Name.visible = false
	var text:String
	if context == GC.ENEMY:
		text = """hp: {hp}
		attack: {attack}
		""".format({
			"hp": entity.current_hp,
			"attack": entity.attack,
			})
	elif context == GC.PLAYER:
		text = """hp: {hp}
		attack: {attack}
		shield: {shield}
		distance: {distance}
		""".format({
			"hp": entity.current_hp,
			"attack": entity.attack,
			"shield": entity.shield,
			"distance": entity.steps})
	$Name.text = entity.name
	$TextLabel.text = text
	#if entity.icon:
		#$TextureRect.texture = entity.icon
func setup_place(place: PlaceData):
	$Name.text = place.name
func setup_vis(data):
	if data is ItemStack:
		$TextLabel.text = (
			"X" + str(data.quantity)
			+ "\n $ " + str(data.cost)
			)
		for i in data.equip_bonus:
			
			
			$TextLabel.text += "\n" + i + " " + str(data.equip_bonus[i])
		$EquipedIcon.visible = data.equiped
	$Name.text = data.name
	name = data.name
	
func _on_button_select_mouse_button_left() -> void:
	if context in [GC.PLAYER, GC.FAR_PLACE]:
		return
	if card_data is EntityData:
		EventBus.card_selected.emit(card_data)
	elif card_data is PlaceData:
		if card_data.actions.size() == 1:
			if card_data.actions[0].menu:
				EventBus.menu.emit(card_data.actions[0], card_data.actions[0].type)
			else:
				ActionManager.handle_action(card_data.actions[0], card_data.actions[0].type)
			return
		EventBus.menu.emit(card_data, context)
	elif card_data is ItemStack:
		item_stack_clicked.emit(card_data)
	elif card_data is ActionData:
		ActionManager.handle_action(card_data, context)
func _on_button_select_mouse_button_right() -> void:
	if context in [GC.PLAYER, GC.FAR_PLACE]:
		return
	if card_data is ItemStack:
		if card_data.actions:
			if card_data.editor_main_type == card_data.EditorType.USE:
				if card_data.quantity > QUANTITY_MENU_THRESHOLD:
					EventBus.show_quantity_menu.emit(true, card_data.quantity, [])
					EventBus.result_quantity_menu.connect(_on_result_quantity_menu)
					return
				use_item(1)
				return
		elif card_data.editor_main_type == card_data.EditorType.EQUIP:
			card_data.equiped = !card_data.equiped
			setup_vis(card_data)
			ActionManager.handle_action(card_data, card_data.type)
func use_item(n) -> void:
	ActionManager.handle_action(card_data.actions[0], card_data.actions[0].type, n)
	if card_data.transforms_to:
		item_stack_create.emit(card_data.transforms_to, n)
	item_stack_delete.emit(card_data, n)
func _on_result_quantity_menu(n: int, _buffer: Array) -> void:
	if n > 0:
		use_item(n)
	if EventBus.result_quantity_menu.is_connected(_on_result_quantity_menu):
		EventBus.result_quantity_menu.disconnect(_on_result_quantity_menu)
