extends Control

func _ready() -> void:
	EventBus.death_screen_changed.connect(show_death_screen)
func _on_button_ok_pressed() -> void:
	#visible = false
	EventBus.death_screen_changed.emit(false)
	
	EventBus.main_menu_changed.emit(true)
func show_death_screen(vis: bool, end_game: bool = false):
	visible = vis
	if vis:
		var player_data: Resource = ActionManager.player
		for i in player_data.equip_slots.keys():
			EventBus.check_equip.emit(player_data.equip_slots[i])
		player_data.real_inv2.clear()
		player_data.steps = 0
		player_data.armor = 0
		player_data.damage = 10
		player_data.max_hp = 100
		player_data.current_hp = max(0, player_data.current_hp)
		GC.story_step = 0
		
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
