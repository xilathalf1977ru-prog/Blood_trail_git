extends Node

var place_time: Array[int]:
	get: return get_parent().place_time
var places_templates: Dictionary[String, Resource]:
	get: return get_parent().places_templates
var items_templates: Dictionary[String, Resource]:
	get: return get_parent().items_templates

func create_map(place_map) -> Dictionary:
	var pockets = []
	#for i in 5:
		#pockets.append(Factory.create_inv(places_templates, items_templates))
	place_map[-1] = places_templates["store"]
	#place_map[-2] = places_templates["cave"]
	#place_map[-1] = places_templates["tower"]
	place_map[0] = places_templates["home"]
	place_map[2] = places_templates["mushroom_young"]
	#place_map[2] = places_templates["stone_and_sword"]
	var a = [
		#places_templates["portal"],
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
		if place_map[i].timed:
			place_time.append(i)
func create_mirrors_places(place_map):
	for i in place_map.keys():
		place_map[i + (GC.END_WORLD * 2 + 1)] = place_map[i]
		place_map[i - (GC.END_WORLD * 2 + 1)] = place_map[i]

func add_place_rng(place_map):
	var available_keys: Array = range(-GC.END_WORLD, GC.END_WORLD+1)
	for used_key in place_map.keys():
		available_keys.erase(used_key)
	if available_keys.is_empty(): 
		return place_map
	
	
	
	var random_index: int = (randi() % available_keys.size())
	var cell: int = available_keys[random_index]
	var place: Resource = Factory.create_place_rng(places_templates, items_templates)
	#print(place_time)
	if place.timed:
		place_time.append(cell)
		#print(place_time)
	available_keys.remove_at(random_index)
	return add_place(place_map, place, cell)
func add_place(place_map, place, cell):
	place_map[cell] = place
	place_map[cell + (GC.END_WORLD * 2 + 1)] = place_map[cell]
	place_map[cell - (GC.END_WORLD * 2 + 1)] = place_map[cell]
	return place_map
