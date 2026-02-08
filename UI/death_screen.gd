extends Control


func _on_main_menu_button_pressed() -> void:
	EventBus.death_screen_changed.emit(false)
	EventBus.main_menu_changed.emit(true)
