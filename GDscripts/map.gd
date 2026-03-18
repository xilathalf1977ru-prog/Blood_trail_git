extends Node2D

var place_map: Dictionary[int, Resource] = {}
var place_time: Array[int] = []

var places_templates: Dictionary[String, Resource] = {}
var items_templates: Dictionary[String, Resource] = {}
var currently_visible_cells: Array = []
func _ready():
	places_templates = DataLoader.load_res_dict("res://Data/Places/")
	items_templates = DataLoader.load_res_dict("res://Data/Items/")
	black_list_random_item()
	EventBus.player_moved.connect(update_places)
	EventBus.delete_place.connect(on_delete_place)
	EventBus.time_ticked.connect(on_time_ticked)
	var pockets = []
	for i in 6:
		pockets.append(Factory.create_inv(places_templates, items_templates))
	place_map = {
		-4:pockets[0],
		-3:pockets[1],
		-2:pockets[2],
		-1:places_templates["portal"],
		0:places_templates["store"],
		1:pockets[3],
		2:pockets[4],
		3:pockets[5],
		4:places_templates["home"],
		9:places_templates["stone_and_sword"],
	}
	create_time_places()
	create_mirrors_places()
	call_deferred("autorun")
func autorun():update_places(Vector2(0, 0))
func update_places(player_pos: Vector2):
	@warning_ignore("narrowing_conversion")
	var player_cell: int = player_pos.x/GC.CELL
	var visible_radius: int = 5
	var new_visible_cells: Array = []
	for cell in place_map.keys():# Находим все клетки в радиусе видимости, где есть места
		if abs(cell - player_cell) <= visible_radius:
			new_visible_cells.append(cell)
	var became_visible: Array = []# Определяем какие места стали видны, а какие скрылись
	var became_hidden: Array = []
	for cell in new_visible_cells:
		if not currently_visible_cells.has(cell):
			became_visible.append(cell)
	for cell in currently_visible_cells:
		if not new_visible_cells.has(cell):
			became_hidden.append(cell)
	for cell in became_visible:# Сообщаем GameWorld о изменениях видимости	
		if place_map.has(cell):
			EventBus.place_visibility_changed.emit(cell, place_map[cell], true)
	for cell in became_hidden:
		if place_map.has(cell):
			EventBus.place_visibility_changed.emit(cell, place_map[cell], false)
	currently_visible_cells = new_visible_cells
func has_save_file() -> bool:
	return FileAccess.file_exists("user://save.tres")
func on_delete_place(place_data):
	if place_data in place_map.values():
		place_map.erase(place_map.find_key(place_data))
		delete_mirrors_places(place_data)
func create_mirrors_places():
	for i in place_map.keys():
		place_map[i + (GC.END_WORLD * 2 + 1)] = place_map[i]
		place_map[i - (GC.END_WORLD * 2 + 1)] = place_map[i]
func delete_mirrors_places(place_data):
	place_map.erase(place_map.find_key(place_data))
	place_map.erase(place_map.find_key(place_data))

func create_time_places():
	for i in place_map.keys():
		if place_map[i].type == "trade":
			place_time.append(i)
func black_list_random_item():
	items_templates.erase("sword_wolfkiller")
	items_templates.erase("wolf_head")
	items_templates.erase("goblin_head")
	items_templates.erase("goblin_fat_head")
	
func on_time_ticked(_time_now):
	var item_name: String = items_templates.keys().pick_random()
	for i in place_time:
		ActionManager.add_item(place_map[i], items_templates[item_name])
