extends Node2D

func setup(data: Resource, type: String):
	fade_in(self, GC.anim_speed * 2)
	data.position = position
	$CardEntity.setup(data, type)
	$CardEntity.set_select_handler(Callable(self, "select"))

func select(card_data: Resource, context: String) -> void:
	if context in [GC.PLAYER, GC.FAR_PLACE]:
		return
	if card_data is EntityData:
		EventBus.card_selected.emit(card_data)

func fade_out(node, duration: float = GC.anim_speed):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)
	tween.tween_callback(func(): node.visible = false)
	await tween.finished
func fade_in(node, duration: float = GC.anim_speed):
	node.visible = true
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)
	await tween.finished
