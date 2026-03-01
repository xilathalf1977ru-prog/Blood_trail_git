extends Button

@warning_ignore("unused_signal")
signal extra_button

var extra_button_data: Resource = null
func set_extra_button(data: Resource) -> void:
	if data.EditorType.EQUIP == data.editor_main_type:
		$ButtonExtra.visible = true
		extra_button_data = data
		ui_extra_button(data.EditorType.EQUIP)
	elif data.EditorType.USE == data.editor_main_type:
		$ButtonExtra.visible = true
		extra_button_data = data
		ui_extra_button(data.EditorType.USE)
	else: 
		$ButtonExtra.visible = false
func ui_extra_button(type: int):
	if type == extra_button_data.EditorType.EQUIP:
		$ButtonExtra/EquipedIcon.visible = extra_button_data.equiped
		if extra_button_data.equiped:
			$ButtonExtra.text = "Снять"
		else:
			$ButtonExtra.text = "Надеть"
	elif type == extra_button_data.EditorType.USE:
		$ButtonExtra.text = "Пить"
func _on_button_equip_pressed() -> void:
	extra_button_data.equiped = !extra_button_data.equiped
	ui_extra_button(extra_button_data.editor_main_type)
	extra_button.emit()
