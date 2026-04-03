extends Control

func _ready() -> void:
	EventBus.death_screen_changed.connect(show_death_screen)
func _on_button_ok_pressed() -> void:
	visible = false
	EventBus.main_menu_changed.emit(true)
func show_death_screen(vis: bool, end_game: bool = false):
	visible = vis
	if end_game:
		$Skull.visible = !end_game
		$Log.visible = !end_game
		$Label2.visible = end_game
		$BadEnd.visible = end_game
		$Label2.text = TR.lc("bad_end")
	else:
		$Skull.visible = !end_game
		$Log.visible = !end_game
		$Label2.visible = end_game
		$BadEnd.visible = end_game
