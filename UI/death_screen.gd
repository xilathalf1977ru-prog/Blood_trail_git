extends Control

func _on_button_ok_pressed() -> void:
	EventBus.death_screen_changed.emit(false)
	EventBus.main_menu_changed.emit(true)
