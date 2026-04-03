extends Node

var place_time: Array[int]:
	get: return get_parent().place_time
var places_templates: Dictionary[String, Resource]:
	get: return get_parent().places_templates
var items_templates: Dictionary[String, Resource]:
	get: return get_parent().items_templates

func create_map(place_map) -> Dictionary:
	var pockets = []
	for i in 5:
		pockets.append(Factory.create_inv(places_templates, items_templates))
	place_map[1] = places_templates["home"]
	place_map[-1] = places_templates["cave"]
	place_map[-2] = places_templates["tower"]
	place_map[4] = places_templates["store"]
	place_map[0] = places_templates["stone_and_sword"]
	var a = [
		places_templates["portal"],
		#places_templates["store"],
		]
	a.append_array(pockets)
	
	var available_keys: Array = range(-GC.END_WORLD, GC.END_WORLD+1)
	for used_key in place_map.keys():
		available_keys.erase(used_key)
	a.shuffle()
	for item in a:
		if available_keys.is_empty(): break
		var random_index = randi() % available_keys.size()
		place_map[available_keys[random_index]] = item
		available_keys.remove_at(random_index)
	
	create_time_places(place_map)
	create_mirrors_places(place_map)
	return place_map
func create_time_places(place_map):
	for i in place_map.keys():
		if place_map[i].type == "trade":
			place_time.append(i)
func create_mirrors_places(place_map):
	for i in place_map.keys():
		place_map[i + (GC.END_WORLD * 2 + 1)] = place_map[i]
		place_map[i - (GC.END_WORLD * 2 + 1)] = place_map[i]

func add_place(place_map):
	var a = []
	a.append(Factory.create_inv(places_templates, items_templates))
	
	var available_keys: Array = range(-GC.END_WORLD, GC.END_WORLD+1)
	for used_key in place_map.keys():
		available_keys.erase(used_key)
	a.shuffle()
	var random_index: int
	var cell: int
	for item in a:
		if available_keys.is_empty(): break
		random_index = (randi() % available_keys.size())
		cell = available_keys[random_index]
		place_map[cell] = item
		available_keys.remove_at(random_index)
	
	#print(cell)
	#print(cell + (GC.END_WORLD * 2 + 1))
	#print(cell - (GC.END_WORLD * 2 + 1))
	place_map[cell + (GC.END_WORLD * 2 + 1)] = place_map[cell]
	place_map[cell - (GC.END_WORLD * 2 + 1)] = place_map[cell]
	#print(place_map)
	
		
	return place_map
