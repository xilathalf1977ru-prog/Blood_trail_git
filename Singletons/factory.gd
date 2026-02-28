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
func create_place():
	pass
	#var place_resource = PlaceData.new()
	
func create_inv(places_templates, items_templates):
	var t = places_templates["pocket"].duplicate(true)
	t.id = "pocket" + str(n)
	n += 1
	
	var test_inv = preload("res://Data/Actions/inventory.tres" ).duplicate(true)
	var a = GC.rng.randi_range(0, int(items_templates.size()-1))
	test_inv.type = GC.LOOT
	test_inv.inventory[items_templates[items_templates.keys()[a]]] = 1
	test_inv.on_resource_init()
	t.actions.append(test_inv)
	
	return t
