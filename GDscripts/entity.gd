extends Node2D

var card_data: Resource:
	get:
		return $CardEntity.card_data
var context: String:
	get:
		return $CardEntity.context
func setup(data: Resource, type: String):
	if type != GC.PLAYER:
		fade_in(self, GC.anim_speed * 2)
		data.position = position
	elif type == GC.PLAYER:
		print("2223")
		$CardEntity/TextureRect.scale.x *=-1 
	$CardEntity.setup(data, type)
	var text:String
	text = """
	{hp}: {hp_n}
	{damage}: {damage_n}
	{armor}: {armor_n}
	""".format({
		"armor": TR.lc("armor"),
		"damage": TR.lc("damage"),
		"hp": TR.lc("hp"),
		"hp_n": card_data.current_hp,
		"damage_n": card_data.damage,
		"armor_n": card_data.armor,
		})
	$TextLabel.text = text
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


func _on_button_select_pressed() -> void:
	if card_data is EntityData and context != GC.PLAYER:
		EventBus.card_selected.emit(card_data)


func _on_button_select_mouse_entered() -> void:
	if card_data is EntityData or card_data is ItemStack or card_data is PlaceData:
		$TextLabel.visible = true
	if card_data is EntityData and context != GC.PLAYER:
		EventBus.show_player_stats.emit(true)
func _on_button_select_mouse_exited() -> void:
	$TextLabel.visible = false
	if card_data is EntityData and context != GC.PLAYER:
		EventBus.show_player_stats.emit(false)
