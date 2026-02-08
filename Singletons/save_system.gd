extends Node

const SAVE_PATH:String = "user://save.tres"

func save_game(
data: EntityData,
current_enemies: Array[EntityData],
invs: Dictionary[String, Array],
invs_money: Dictionary[String, int],
):
	# 1. Создаём ресурс для сохранения
	var save_resource = SaveData.new()
	save_resource.player_data = data.duplicate()
	save_resource.enemies = current_enemies.duplicate()
	
	save_resource.invs = invs.duplicate()
	
	save_resource.invs_money = invs_money
	# 2. Сохраняем в файл
	var error = ResourceSaver.save(save_resource, SAVE_PATH)
	
	if error == OK:
		print("Файл сохранения создан: ", SAVE_PATH)
	else:
		print("Ошибка сохранения: ", error)
func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var save_resource = ResourceLoader.load(SAVE_PATH)
		return save_resource # ⬅️ Возвращаем данные
	return null
