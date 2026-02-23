extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		EventBus.player_move.emit(Vector2.RIGHT)
	if event.is_action_pressed("move_left"):
		EventBus.player_move.emit(Vector2.LEFT)
	if event.is_action_pressed("move_forward"):
		EventBus.player_move.emit(Vector2.UP)
	if event.is_action_pressed("move_back"):
		EventBus.player_move.emit(Vector2.DOWN)
	
	if event.is_action_pressed("save"):
		EventBus.save.emit()
	elif event.is_action_pressed("load"):
		GameManager.load_game()
	elif event.is_action_pressed("pause"):
		EventBus.all_menus_close.emit()
