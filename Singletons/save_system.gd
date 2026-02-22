extends Node

#const save_path:String = "user://save.tres"

#func save_game(
#save_path: String,
#data: EntityData,
#current_enemies: Array[EntityData],
#invs: Dictionary[String, Array],
#invs_money: Dictionary[String, int],
#):
	## 1. Создаём ресурс для сохранения
	#var save_resource = SaveData.new()
	#save_resource.player_data = data.duplicate()
	#save_resource.enemies = current_enemies.duplicate()
	#
	#save_resource.invs = invs.duplicate()
	#
	#save_resource.invs_money = invs_money
	## 2. Сохраняем в файл
	#var error = ResourceSaver.save(save_resource, save_path)
	#
	#if error == OK:
		#print("Файл сохранения создан: ", save_path)
	#else:
		#print("Ошибка сохранения: ", error)
func load_game(save_path: String):
	if FileAccess.file_exists(save_path):
		var save_resource = ResourceLoader.load(save_path)
		return save_resource # ⬅️ Возвращаем данные
	return null
