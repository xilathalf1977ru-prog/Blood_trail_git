extends Node2D

var card_data: Resource:
	get:
		return $CardPlace.card_data
func setup(data: Resource, type: String):
	$CardPlace.setup(data, type)
	$CardPlace.set_select_handler(Callable(self, "select"))

func select(_card_data: Resource, context: String) -> void:
	if context in [GC.PLAYER, GC.FAR_PLACE]:
		return
	if card_data.actions.size() == 1 and card_data.type == GC.LOOT:
		ActionManager.handle_action(card_data, card_data.type)
		return
	EventBus.menu.emit(card_data, context)

func _on_button_select_pressed():
	$CardPlace.select()
