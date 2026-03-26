extends TextureRect

const QUANTITY_MENU_THRESHOLD: int = 3
var context: String
var card_data: Resource
@warning_ignore("unused_signal")
signal item_stack_clicked(item_stack: ItemStack)
@warning_ignore("unused_signal")
signal item_stack_use(item_stack: ItemStack)
func setup(data: Resource, type: String):
	card_data = data
	context = type
	if data.sprites:
		$Anim.sprite_frames = data.sprites
		$Anim.play()
		$TextureRect.visible = false
	if data.icon:
		$TextureRect.texture = data.icon
	actions_icon(data, type)
func actions_icon(data, type):
	if type in [GC.Act.SLEEP, GC.Act.ROB]:
		$TextureRect.texture = data.actions[type]
func setup_vis(data, name_owner):
	if data is ItemStack:
		$TextLabel.text = (
			"X" + str(data.quantity)
			+ "\n $" + str(data.cost)
			)
		for i in data.equip_bonus:
			$TextLabel.text += "\n" + TR.lc(i) + " " + str(data.equip_bonus[i])
		$TextureRect.size = Vector2(96, 96)
		$TextureRect.position = Vector2(-64, -64)
		if name_owner == "player":
			$ButtonSelect.set_extra_button(data)
			
			
		$TextLabel.position = Vector2(224, 32)
		$Name.text = TR.lc(data.name) + " X" + str(data.quantity)
	else:
		$Name.visible = false
	name = data.name
func _on_button_select_pressed() -> void:
	if card_data is ItemStack:
		item_stack_clicked.emit(card_data)
	elif context in [GC.Act.INV, GC.Act.TRADE, 
	GC.Act.TELEPORT_RNG, GC.Act.SLEEP, GC.Act.ROB]:
		ActionManager.handle_action(card_data, context)
func _on_result_quantity_menu(n: int, _buffer: Array) -> void:
	if n > 0:
		item_stack_use.emit(card_data, n)
	if EventBus.result_quantity_menu.is_connected(_on_result_quantity_menu):
		EventBus.result_quantity_menu.disconnect(_on_result_quantity_menu)
func _on_button_select_mouse_entered() -> void:

	if card_data is ItemStack:
		$TextLabel.visible = true
func _on_button_select_mouse_exited() -> void:
	$TextLabel.visible = false
func _on_button_select_extra_button() -> void:
	item_stack_use.emit(card_data, 1)
