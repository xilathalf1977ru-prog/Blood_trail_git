extends Button

var extra_button_data: Resource = null
func _ready() -> void:
	EventBus.equip.connect(on_equip)
	EventBus.unequip.connect(on_unequip)
func set_extra_button(data: Resource) -> void:
	if data.main_type in ["HEAL", "BONUS", "EQUIP"]:
		visible = true
		extra_button_data = data
		ui_extra_button(data, data.main_type)
	else:
		visible = false
func ui_extra_button(data, type: String):
	if type == "EQUIP":
		#add_theme_font_size_override("font_size", 64)
		var equiped: bool
		for i in GameManager.player_ref.data.equip_slots.values():
			if i.name == data.name:
				equiped = true
				break
		$EquipedIcon.visible = equiped
		if equiped:
			text = "-"
		else:
			text = "+"
	elif type == "HEAL" or "BONUS":
		#add_theme_font_size_override("font_size", 40)
		text = TR.lc("Drink")#"Пить"
		if "head" in data.name:
			text = TR.lc("Eat")
func on_equip(data: Resource) -> void:
	if data == extra_button_data: ui_extra_button(data, data.main_type)
func on_unequip(data: Resource) -> void:
	if data == extra_button_data: ui_extra_button(data, data.main_type)
