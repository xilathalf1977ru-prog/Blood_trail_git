extends Node

func save_game(
save_path: String,
data: EntityData,
current_enemies: Array[EntityData],
invs: Dictionary[String, Dictionary],
invs_money: Dictionary[String, int],
):
	# 1. Создаём ресурс для сохранения
	var save_resource = SaveData.new()
	save_resource.player_data = data.duplicate()
	save_resource.enemies = current_enemies.duplicate()
	
	save_resource.invs = invs.duplicate()
	
	save_resource.invs_money = invs_money
	# 2. Сохраняем в файл
	var error = ResourceSaver.save(save_resource, save_path)
	
	if error == OK:
		print("Файл сохранения создан: ", save_path)
	else:
		print("Ошибка сохранения: ", error)
var n: int = 0
func create_place_rng(places_templates, items_templates):
	#var arr_names: Array = ["pocket", "mushroom_young"]
	var place_name: String = "mushroom_young"#arr_names.pick_random()
	
	var place: Resource = places_templates[place_name].duplicate(true)
	place.id = place_name + str(n)
	n += 1
	var random_item: int = GC.rng.randi_range(0, int(items_templates.size()-1))
	place.inventory[items_templates[items_templates.keys()[random_item]]] = 1
	place.on_resource_init()
	place.ticks = 0
	return place


func create_place(places_templates, items_templates):
	var place: Resource = places_templates["pocket"].duplicate(true)
	place.id = "pocket" + str(n)
	n += 1
	var random_item: int = GC.rng.randi_range(0, int(items_templates.size()-1))
	place.inventory[items_templates[items_templates.keys()[random_item]]] = 1
	place.on_resource_init()
	return place
