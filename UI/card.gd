extends TextureRect

const QUANTITY_MENU_THRESHOLD: int = 3
var context: String
var card_data: Resource
var select_handler: Callable
@warning_ignore("unused_signal")
signal item_stack_clicked(item_stack: ItemStack)
@warning_ignore("unused_signal")
signal item_stack_use(item_stack: ItemStack)
func setup(data: Resource, type: String):
	card_data = data
	context = type
	if data is EntityData:setup_entity(data as EntityData)
	elif data is PlaceData:setup_place(data as PlaceData)
	if name != "CardPlayer" and name != "CardEntity" and name != "CardPlace" and $Name.text:
		name = $Name.text
	if data.sprites:
		$Anim.sprite_frames = data.sprites
		$Anim.play()
		$TextureRect.visible = false
	if data.icon:
		$TextureRect.texture = data.icon

func set_select_handler(handler: Callable) -> void:
	select_handler = handler

func select() -> void:
	if context in [GC.PLAYER, GC.FAR_PLACE]:
		return
	if select_handler.is_valid():
		select_handler.call(card_data, context)
		return
	if card_data is ItemStack:
		item_stack_clicked.emit(card_data)
	elif card_data is ActionData:
		ActionManager.handle_action(card_data, context)
func setup_entity(entity: EntityData):
	$Name.visible = false
	var text:String
	text = """
	{hp}: {hp_n}
	{damage}: {damage_n}
	{armor}: {armor_n}
	""".format({
		"armor": TR.lc("armor"),
		"damage": TR.lc("damage"),
		"hp": TR.lc("hp"),
		"hp_n": entity.current_hp,
		"damage_n": entity.damage,
		"armor_n": entity.armor,
		})
	$Name.text = entity.name
	$TextLabel.text = text
func setup_place(place: PlaceData):
	$Name.visible = false
	$Name.text = place.name
	$TextLabel.text = ""
func setup_vis(data, name_owner):
	if data is ItemStack:
		$TextLabel.text = (
			"X" + str(data.quantity)
			+ "\n $ " + str(data.cost)
			)
		for i in data.equip_bonus:
			$TextLabel.text += "\n" + TR.lc(i) + " " + str(data.equip_bonus[i])
		$TextureRect.size = Vector2(96, 96)
		$TextureRect.position = Vector2(-64, -64)
		if name_owner == "player":
			$ButtonSelect.set_extra_button(data)
		$TextLabel.position = Vector2(224, 32)
		#$Name.text = data.name + " X" + str(data.quantity)
		$Name.text = TR.lc(data.name) + " X" + str(data.quantity)
	else:
		$Name.visible = false
	name = data.name
func _on_button_select_pressed() -> void:
	select()
func _on_result_quantity_menu(n: int, _buffer: Array) -> void:
	if n > 0:
		item_stack_use.emit(card_data, n)
	if EventBus.result_quantity_menu.is_connected(_on_result_quantity_menu):
		EventBus.result_quantity_menu.disconnect(_on_result_quantity_menu)
func _on_button_select_mouse_entered() -> void:
	if card_data is EntityData or card_data is ItemStack or card_data is PlaceData:
		$TextLabel.visible = true
	if card_data is EntityData and context != GC.PLAYER:
		EventBus.show_player_stats.emit(true)
func _on_button_select_mouse_exited() -> void:
	$TextLabel.visible = false
	if card_data is EntityData and context != GC.PLAYER:
		EventBus.show_player_stats.emit(false)
func _on_button_select_extra_button() -> void:
	item_stack_use.emit(card_data, 1)
