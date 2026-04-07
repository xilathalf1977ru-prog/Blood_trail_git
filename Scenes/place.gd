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
	fade_in($CardPlace)
func fade_in(node, duration: float = GC.anim_speed):
	node.visible = true
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)
	await tween.finished
func _on_button_select_pressed():
	if card_data.type == GC.LOOT:
		ActionManager.handle_action(card_data, card_data.type)
	elif card_data.type == GC.HOME:
		EventBus.menu.emit(card_data, context)
	elif card_data.type == GC.Act.TELEPORT_RNG:
		EventBus.menu.emit(card_data, context)
	elif card_data.type == GC.Act.TRADE:
		if card_data.real_inv == []:
			card_data.actions.erase(GC.Act.ROB)
		else:
			card_data.actions[GC.Act.ROB] = preload("res://UI/rob.webp")
		EventBus.menu.emit(card_data, context)
	elif card_data.type == GC.DUNGEON:
		if card_data.real_inv == []:
			card_data.actions.erase(GC.Act.ROB)
		else:
			card_data.actions[GC.Act.ROB] = preload("res://UI/rob.webp")
		EventBus.menu.emit(card_data, context)
func _on_button_select_mouse_entered() -> void:
	$ColorRect.visible = true
func _on_button_select_mouse_exited() -> void:
	$ColorRect.visible = false
