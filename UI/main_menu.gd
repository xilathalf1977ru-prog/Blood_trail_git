extends Control

func _ready():
##АВТОЗАПУСК
	call_deferred("autorun")
func autorun():
	print_debug("АВТОЗАПУСК")
	_on_new_game_button_pressed()
func _on_new_game_button_pressed() -> void:
	load_scene("res://Scenes/game_world.tscn")
	EventBus.main_menu_changed.emit(false)
func _on_exit_button_pressed() -> void:
	get_tree().quit()
func load_scene(scene_path: String):
	var scene = load(scene_path).instantiate()
	get_tree().root.add_child(scene)
