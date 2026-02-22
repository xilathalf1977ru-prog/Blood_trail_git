extends Button

@warning_ignore("unused_signal")
signal mouse_button_left
@warning_ignore("unused_signal")
signal mouse_button_right
func _gui_input(event):
	if !event is InputEventMouseButton or !event.pressed:
		return
	match event.button_index:
		MOUSE_BUTTON_LEFT:
			mouse_button_left.emit()
		MOUSE_BUTTON_RIGHT:
			mouse_button_right.emit()
