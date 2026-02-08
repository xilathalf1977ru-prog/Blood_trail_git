extends Node

var scenes_by_type:Dictionary = {}
func register_scene(scene: Node, scene_type: String):
	scenes_by_type[scene_type] = scene
func unregister_scene(scene_type: String):
	scenes_by_type.erase(scene_type)
func delete_scene_by_type(scene_type: String):
	if scenes_by_type.has(scene_type):
		scenes_by_type[scene_type].queue_free()
		scenes_by_type.erase(scene_type)
func load_scene(scene_path: String):
	var scene = load(scene_path).instantiate()
	get_tree().root.get_node("Main").add_child(scene)
func load_scene_to_parent(scene_path: String, parent_node: String):
	var scene = load(scene_path).instantiate()
	scenes_by_type[parent_node].add_child(scene)
func new_game():
	load_scene("res://Scenes/game_world.tscn")
	EventBus.main_menu_changed.emit(false)
	#delete_scene_by_type("main_menu")
func quit_game():
	get_tree().quit()
