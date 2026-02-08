extends Sprite2D

var context: String
var card_data: Resource
@warning_ignore("unused_signal")
signal item_stack_clicked(item_stack: ItemStack)
func setup(data: Resource, type: String):
	card_data = data
	context = type
	if data is EntityData:setup_entity(data as EntityData)
	elif data is PlaceData:setup_place(data as PlaceData)
	#elif data is ItemStack:setup_item(data as ItemStack)
	#elif data is ActionData:setup_action(data as ActionData)
func setup_entity(entity: EntityData):
	var text:String
	if context == GC.ENEMY:
		text = """ХП: {hp}
		Урон: {damage}
		""".format({
			"hp": entity.current_hp,
			"damage": entity.damage,
			})
	elif context == GC.PLAYER:
		text = """ХП: {hp}
		Урон: {damage}
		Шаги от дома: {steps}
		""".format({
			"hp": entity.current_hp,
			"damage": entity.damage,
			"steps": entity.steps})
	$Name.text = entity.name
	$TextLabel.text = text
func setup_place(place: PlaceData):
	$Name.text = place.name
func setup_vis(data, context2):
	if context2 in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]:
		$Name.text = data.name
		$TextLabel.text = (
			"X" + str(data.quantity)
			+ "\n $ " + str(data.cost)
			)
	elif context2 in [GC.PLACE]:
		$Name.text = data.name
func _on_button_select_pressed() -> void:
	if context in [GC.PLAYER, GC.FAR_PLACE]:
		_on_button_info_pressed()
		return
	on_selected()
func on_selected():
	if card_data is EntityData:
		EventBus.card_selected.emit(card_data, context)
	elif card_data is PlaceData:
		EventBus.menu.emit(card_data, context)
	elif card_data is ItemStack:
		item_stack_clicked.emit(card_data)
	elif card_data is ActionData:
		ActionManager.handle_action(card_data, context)
func _on_button_info_pressed() -> void:
	EventBus.card_details_requested.emit(card_data)
func on_up_step_card(deleted_card_pos_y) -> void:
	const STEP_Y: int = 360
	if deleted_card_pos_y < position.y:
		position.y -=STEP_Y
