extends Node2D

var place_map: Dictionary
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
	place_map = $map_create.create_map(place_map)
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
func delete_mirrors_places(place_data):
	place_map.erase(place_map.find_key(place_data))
	place_map.erase(place_map.find_key(place_data))
func black_list_random_item():
	items_templates.erase("sword_wolfkiller")
	items_templates.erase("wolf_head")
	items_templates.erase("goblin_head")
	items_templates.erase("goblin_fat_head")
func on_time_ticked(_time_now):
	var item_name: String = items_templates.keys().pick_random()
	for i in place_time:
		ActionManager.add_item(place_map[i], items_templates[item_name])
