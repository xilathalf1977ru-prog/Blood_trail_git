extends Control

func _ready():
##АВТОЗАПУСК
	call_deferred("autorun")
func autorun():
	print_debug("АВТОЗАПУСК")
	_on_button_start_pressed()
func _on_button_start_pressed() -> void:
	load_scene("res://Scenes/game_world.tscn")
	EventBus.main_menu_changed.emit(false)
func load_scene(scene_path: String):
	var scene = load(scene_path).instantiate()
	get_tree().root.add_child(scene)
func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _on_button_ru_pressed() -> void:
	TR.lang = "ru"
func _on_button_en_pressed() -> void:
	TR.lang = "en"
