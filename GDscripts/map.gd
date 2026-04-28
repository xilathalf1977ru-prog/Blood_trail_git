extends Node2D

var place_map: Dictionary
var place_time: Array[int] = []
var places_templates: Dictionary[String, Resource] = {}
var items_templates: Dictionary[String, Resource] = {}
var items_templates_shop: Dictionary[String, Resource] = {}
var currently_visible_cells: Array = []

signal places_vis

func _ready():
	places_templates = DataLoader.load_res_dict("res://Data/Places/")
	items_templates = DataLoader.load_res_dict("res://Data/Items/")
	items_templates_shop.merge(items_templates)
	black_list_random_item()
	EventBus.player_moved.connect(update_places)
	EventBus.delete_place.connect(on_delete_place)
	EventBus.time_ticked.connect(on_time_ticked)
	EventBus.create_place.connect(on_create_place)
	place_map = $map_create.create_map(place_map)
	call_deferred("autorun")
func autorun():update_places(Vector2(0, 0))
func update_places(player_pos: Vector2):
	@warning_ignore("narrowing_conversion")
	var player_cell: int = player_pos.x/GC.CELL
	var visible_radius: int = 5
	var arr: Array = []
	for i in 11:
		arr.append(null)
	for cell in place_map.keys():# Находим все клетки в радиусе видимости, где есть места
		if abs(cell - player_cell) <= visible_radius:
			var index: int = cell+5+(player_cell*-1)
			arr[index] = place_map[cell]
	places_vis.emit(arr)
func has_save_file() -> bool:
	return FileAccess.file_exists("user://save.tres")
func on_delete_place(place_data):
	if place_data in place_map.values():
		place_map.erase(place_map.find_key(place_data))
		delete_mirrors_places(place_data)
		
		
		var player_pos: Vector2 = ActionManager.player.position
		update_places(player_pos)
func delete_mirrors_places(place_data):
	place_map.erase(place_map.find_key(place_data))
	place_map.erase(place_map.find_key(place_data))
func black_list_random_item():
	items_templates.erase("sword_wolfkiller")
	items_templates.erase("wolf_head")
	items_templates.erase("goblin_head")
	items_templates.erase("goblin_fat_head")
	items_templates.erase("bear_head")
	items_templates.erase("elixir_max_hp_10")
	items_templates.erase("strange_armor")
	
	items_templates_shop.erase("sword_wolfkiller")
	items_templates_shop.erase("wolf_head")
	items_templates_shop.erase("goblin_head")
	items_templates_shop.erase("goblin_fat_head")
	items_templates_shop.erase("bear_head")
	items_templates_shop.erase("strange_armor")
func on_time_ticked(_time_now):
	print(place_time)
	var item_name: String = items_templates_shop.keys().pick_random()
	for i in place_time:
		if place_map[i].trade:
			place_map[i].add_item(items_templates_shop[item_name], 1)
		if place_map[i].timed:
			place_map[i].ticks += 1
			#if place_map[i].name == "Mushroom" and place_map[i].ticks > 1:
			if place_map[i].name in ["Mushroom", "Mushroom young"] and place_map[i].ticks > 1:
				var trans = place_map[i].transform_to
				on_delete_place(place_map[i])
				var a: Dictionary = $map_create.add_place(place_map.duplicate(), trans, i)
				place_map.merge(a)
				var player_pos: Vector2 = ActionManager.player.position
				update_places(player_pos)
				
				
			elif place_map[i].name == "Mushroom old" and place_map[i].ticks > 1:
				on_delete_place(place_map[i])
func on_create_place():
	var a: Dictionary = $map_create.add_place_rng(place_map.duplicate())
	place_map.merge(a)
	var player_pos: Vector2 = ActionManager.player.position
	update_places(player_pos)
