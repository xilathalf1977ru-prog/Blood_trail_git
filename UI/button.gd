extends Button

@warning_ignore("unused_signal")
signal extra_button

var extra_button_data: Resource = null

func _ready() -> void:
	EventBus.equip.connect(on_equip)
	EventBus.unequip.connect(on_unequip)

func set_extra_button(data: Resource) -> void:
	if data.main_type == "EQUIP":
		$ButtonExtra.visible = true
		extra_button_data = data
		ui_extra_button(data, data.main_type)
	elif data.main_type == "USE":
		$ButtonExtra.visible = true
		extra_button_data = data
		ui_extra_button(data, data.main_type)
	else: 
		$ButtonExtra.visible = false
func ui_extra_button(data, type: String):
	if type == "EQUIP":
		$ButtonExtra/EquipedIcon.visible = data.equiped
		$ButtonExtra.add_theme_font_size_override("font_size", 64)
		if data.equiped:
			$ButtonExtra.text = "-"
		else:
			$ButtonExtra.text = "+"
	elif type == "USE":
		$ButtonExtra.add_theme_font_size_override("font_size", 40)
		$ButtonExtra.text = TR.lc("Drink")#"Пить"
func _on_button_equip_pressed() -> void:
	print("ee")
	extra_button.emit()
func on_equip(data: Resource) -> void:
	if data == extra_button_data: ui_extra_button(data, data.main_type)
func on_unequip(data: Resource) -> void:
	if data == extra_button_data: ui_extra_button(data, data.main_type)
