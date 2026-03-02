extends Button

@warning_ignore("unused_signal")
signal extra_button

var extra_button_data: Resource = null

func set_extra_button(data: Resource) -> void:
	if data.main_type == "EQUIP":
		$ButtonExtra.visible = true
		extra_button_data = data
		ui_extra_button(data.main_type)
	elif data.main_type == "USE":
		$ButtonExtra.visible = true
		extra_button_data = data
		ui_extra_button(data.main_type)
	else: 
		$ButtonExtra.visible = false
func ui_extra_button(type: String):
	if type == "EQUIP":
		$ButtonExtra/EquipedIcon.visible = extra_button_data.equiped
		if extra_button_data.equiped:
			$ButtonExtra.text = "Снять"
		else:
			$ButtonExtra.text = "Надеть"
	elif type == "USE":
		$ButtonExtra.text = "Пить"
func _on_button_equip_pressed() -> void:
	extra_button_data.equiped = !extra_button_data.equiped
	ui_extra_button(extra_button_data.main_type)
	extra_button.emit()
