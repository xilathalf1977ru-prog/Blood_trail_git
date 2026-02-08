extends Node2D

var place_cards = {}  # cell: card_node

func _ready() -> void:
	EventBus.cleanup_game.connect(on_cleanup_game)
	EventBus.place_visibility_changed.connect(on_place_visibility_changed)
	call_deferred("resource_init")
func resource_init():
	EventBus.resource_init.emit()
func on_place_visibility_changed(cell: int, place_data: PlaceData, vis: bool):
	if vis:
		spawn_place_card(cell, place_data)
	else:
		despawn_place_card(cell)

func spawn_place_card(cell: int, place_data: PlaceData):
	if place_cards.has(cell):
		return  # Уже существует
	
	# Создаем карточку места
	var card_scene = preload("res://UI/card.tscn")
	var card = card_scene.instantiate()
	
	# Позиционируем в мировых координатах
	card.position = Vector2(cell * GC.CELL, 768)  # Настрой под свои размеры клеток
	card.setup(place_data, GC.FAR_PLACE)  # Передаем данные места
	add_child(card)
	move_child(card, 2)
	place_cards[cell] = card
	
	
func despawn_place_card(cell: int):
	if place_cards.has(cell):
		place_cards[cell].queue_free()
		place_cards.erase(cell)





func on_cleanup_game():
	await get_tree().process_frame
	queue_free()
