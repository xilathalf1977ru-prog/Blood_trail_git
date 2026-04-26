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
	for i in data.actions.size():
		var card: TextureRect = CARD_SCENE.instantiate()
		card.setup(data, data.actions.keys()[i])
		_setup_card_common(card, data)
	update_ui()
func _setup_card_common(card: TextureRect, res_data: Resource) -> void:
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
	card.queue_free()
func _on_button_transfer_pressed() -> void:
	for card in path.get_children():
		inv_stack_clicked.emit(card.card_data, card.card_data.quantity)
func _on_item_stack_clicked(item_stack: ItemStack):
	inv_stack_clicked.emit(item_stack, 1)
func update_ui():
	$ButtonTransfer.visible = local_context in [GC.Act.INV, GC.Act.TRADE, GC.Act.MY_INV]
	$Name.text = TR.lc(local_data.name)
