extends Node2D

var place_map :Dictionary
var places_templates: Array[Resource] = []
var currently_visible_cells = []
func _ready():
	places_templates = DataLoader.load_res("res://Data/Places/")
	EventBus.player_moved.connect(update_places)
	place_map = {
		0:places_templates[2],
		1:places_templates[0],
	}
	call_deferred("autorun")
func autorun():update_places(0)
func update_places(player_cell: int):
	var visible_radius = 5
	var new_visible_cells = []
	# Находим все клетки в радиусе видимости, где есть места
	for cell in place_map.keys():
		if abs(cell - player_cell) <= visible_radius:
			new_visible_cells.append(cell)
	# Определяем какие места стали видны, а какие скрылись
	var became_visible = []
	var became_hidden = []
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
