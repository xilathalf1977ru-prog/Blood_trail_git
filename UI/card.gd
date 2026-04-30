extends TextureRect

const QUANTITY_MENU_THRESHOLD: int = 3
var context: String
var card_data: Resource
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
func setup_vis(data, _name_owner):
	$Name.visible = false
	name = data.name
func _on_button_select_pressed() -> void:
	if context in [GC.Act.INV, GC.Act.TRADE, 
	GC.Act.TELEPORT_RNG, GC.Act.SLEEP, GC.Act.ROB]:
		ActionManager.handle_action(card_data, context)
func _on_button_select_mouse_entered() -> void:
	if card_data is ItemStack:
		$TextLabel.visible = true
func _on_button_select_mouse_exited() -> void:
	$TextLabel.visible = false
