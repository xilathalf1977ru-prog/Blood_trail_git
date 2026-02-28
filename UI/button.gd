extends Button

@warning_ignore("unused_signal")
signal mouse_button_left
@warning_ignore("unused_signal")
signal mouse_button_right


@warning_ignore("unused_signal")
signal equip

var extra_button_data: Resource = null

func _gui_input(event):
	if !event is InputEventMouseButton or !event.pressed:
		return
	match event.button_index:
		MOUSE_BUTTON_LEFT:
			mouse_button_left.emit()
		MOUSE_BUTTON_RIGHT:
			mouse_button_right.emit()
			
			
func set_extra_button(data: Resource) -> void:
	if data.EditorType.EQUIP == data.editor_main_type:
		$ButtonEquip.visible = true
		extra_button_data = data
		ui_extra_button()
	else: 
		$ButtonEquip.visible = false
	
	
func ui_extra_button():
	$ButtonEquip/EquipedIcon.visible = extra_button_data.equiped
	if extra_button_data.equiped:
		$ButtonEquip.text = "Снять"
	else:
		$ButtonEquip.text = "Одеть"
func _on_button_equip_pressed() -> void:
	extra_button_data.equiped = !extra_button_data.equiped
	#$ButtonEquip/EquipedIcon.visible = extra_button_data.equiped
	#if extra_button_data.equiped:
		#$ButtonEquip.text = "Снять"
	#else:
		#$ButtonEquip.text = "Одеть"
	ui_extra_button()
	
	
	equip.emit()
