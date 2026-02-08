class_name BaseScene extends Node

@export var scene_type: String = ""

func _ready():
	if scene_type != "":
		SceneManager.register_scene(self, scene_type)
func _exit_tree():
	if scene_type != "":
		SceneManager.unregister_scene(scene_type)
