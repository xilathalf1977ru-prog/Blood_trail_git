extends Node2D

var place_map: Dictionary = {}
var places_templates: Dictionary[String, Resource] = {}
var items_templates: Dictionary[String, Resource] = {}
var currently_visible_cells: Array = []
func _ready():
	places_templates = DataLoader.load_res_dict("res://Data/Places/")
	items_templates = DataLoader.load_res_dict("res://Data/Items/")
	EventBus.player_moved.connect(update_places)
	
	
	#var testm3 = Factory.create_inv(places_templates, items_templates)
	#var testm2 = Factory.create_inv(places_templates, items_templates)
	#var testm1 = Factory.create_inv(places_templates, items_templates)
	#
	#var test = Factory.create_inv(places_templates, items_templates)
	#var test2 = Factory.create_inv(places_templates, items_templates)
	#var test3 = Factory.create_inv(places_templates, items_templates)
	
	place_map = {
		#-1:testm1,
		#-2:testm2,
		#-3:testm3,
		#-4:places_templates["portal"],
		#0:places_templates["home"],
		#1:test,
		#2:test2,
		#3:test3,
		#4:places_templates["store"],
	}
	
	for i in place_map.keys():
		print(place_map[i].id)
		place_map[i + (GC.END_WORLD * 2 + 1)] = place_map[i]
		place_map[i - (GC.END_WORLD * 2 + 1)] = place_map[i]
	call_deferred("autorun")
func autorun():update_places(Vector2(0, 0))
func update_places(player_pos: Vector2):
	@warning_ignore("narrowing_conversion")
	var player_cell: int = player_pos.x/GC.CELL
	var visible_radius: int = 5
	var new_visible_cells: Array = []
	# Находим все клетки в радиусе видимости, где есть места
	for cell in place_map.keys():
		if abs(cell - player_cell) <= visible_radius:
			new_visible_cells.append(cell)
	# Определяем какие места стали видны, а какие скрылись
	var became_visible: Array = []
	var became_hidden: Array = []
	for cell in new_visible_cells:
		if not currently_visible_cells.has(cell):
			became_visible.append(cell)
	for cell in currently_visible_cells:
		if not new_visible_cells.has(cell):
			became_hidden.append(cell)
	# Сообщаем GameWorld о изменениях видимости	
	for cell in became_visible:
		EventBus.place_visibility_changed.emit(cell, place_map[cell], true)
	for cell in became_hidden:
		EventBus.place_visibility_changed.emit(cell, place_map[cell], false)
		
	currently_visible_cells = new_visible_cells
		# Проверяем стоит ли игрок на месте
	if place_map.has(player_cell):
		EventBus.player_at_place.emit(place_map[player_cell], true)  # вошел
	else:
		EventBus.player_at_place.emit(null, false)  # вышел


func has_save_file() -> bool:
	return FileAccess.file_exists("user://save.tres")
