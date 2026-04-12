extends Node

func _input(event: InputEvent) -> void:
	
	#if event.is_action_pressed("save"):
		#EventBus.save.emit()
	if event.is_action_pressed("load"):
		GameManager.load_game()
	elif event.is_action_pressed("pause"):
		EventBus.all_menus_close.emit()
