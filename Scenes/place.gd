extends Node2D

var card_data: Resource:
	get:
		return $CardPlace.card_data
var context: String:
	get:
		return $CardPlace.context
		
func _ready() -> void:
	$CardPlace/ButtonSelect.queue_free()
func setup(data: Resource, type: String):
	$CardPlace.setup(data, type)
func _on_button_select_pressed():
	$CardPlace._on_button_select_pressed()
	
	if card_data.actions.size() == 1 and card_data.type == GC.LOOT:
		ActionManager.handle_action(card_data, card_data.type)
		return
	EventBus.menu.emit(card_data, context)
