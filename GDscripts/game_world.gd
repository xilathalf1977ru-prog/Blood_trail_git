extends Node2D

const PLACE_OFFSET: Vector2 = Vector2(128, 128)
const PLACE_CARD_LAYER: int = 2
var place_cards: Dictionary = {}
var entities: Array[Node2D]
var current_enemies_pos: Dictionary[Vector2, Resource] = {}
func _ready() -> void:
	EventBus.enemies_generated.connect(show_enemies_cards)
	EventBus.cleanup_game.connect(on_cleanup_game)
	EventBus.place_visibility_changed.connect(on_place_visibility_changed)
	EventBus.player_horizontal_moved.connect(on_player_moved)
	
	EventBus.delete_place.connect(on_delete_place)
	
	call_deferred("resource_init")
	entities = [
		$EnemyChoice/Entity,
		$EnemyChoice/Entity2,
		$EnemyChoice/Entity3,
		$EnemyChoice/Entity4,
		$EnemyChoice/Entity5,
		$EnemyChoice/Entity6,
	]
func resource_init():
	EventBus.resource_init.emit()
	GameManager.current_enemies = EnemyManager.generate_enemies(6)
func on_place_visibility_changed(cell: int, place_data: Resource, vis: bool):
	if vis: spawn_place_card(cell, place_data)
	else: despawn_place_card(cell)
func spawn_place_card(cell: int, data: PlaceData):
	if place_cards.has(cell):
		return  #Уже существует
	var card_scene = preload("res://UI/card.tscn") #Создаем карточку места
	var card = card_scene.instantiate()
	card.position = Vector2((cell * GC.CELL), GC.CELL_Y[2]) - PLACE_OFFSET #Позиционируем в мировых координатах
	card.setup(data, GC.FAR_PLACE)
	add_child(card)
	move_child(card, PLACE_CARD_LAYER)
	place_cards[cell] = card
	on_player_moved(GameManager.player_ref.data.position)
func despawn_place_card(cell: int):
	if place_cards.has(cell):
		place_cards[cell].queue_free()
		place_cards.erase(cell)
func on_cleanup_game():
	await get_tree().process_frame
	queue_free()
func show_enemies_cards(enemies: Array[EntityData]) -> void:
	$EnemyChoice.visible = true
	current_enemies_pos.clear()
	for i in min(enemies.size(), entities.size()):
		var enemy_data: EntityData = enemies[i]
		var card: Node2D = entities[i]
		@warning_ignore("integer_division")
		var side: int = 1 if i > (entities.size()-1)/2 else -1
		card.position = Vector2(
			GameManager.player_ref.data.position.x + GC.CELL * side,
			GC.CELL_Y[enemy_data.direction.y + 1])
		current_enemies_pos[Vector2(side, card.position.y)] = enemy_data
		card.setup(enemy_data, GC.ENEMY)
var last_posx_player: int = 0
func on_player_moved(data):
	var direction_player: int = 0
	if data.x > last_posx_player: direction_player = 1
	elif data.x < last_posx_player: direction_player = -1
	last_posx_player = data.x
	var player_key = Vector2(direction_player, data.y)
	if player_key in current_enemies_pos.keys():
		BattleManager.start_auto_battle(GameManager.player_ref.data, current_enemies_pos[player_key])
	var player_cell: int = data.x/GC.CELL
	var places_pos: Array = []
	for i in place_cards.keys():
		place_cards[i].setup(place_cards[i].card_data, GC.FAR_PLACE)
		places_pos.append(Vector2(i * GC.CELL, GC.cell_place_y))
	if player_cell in place_cards.keys():
		place_cards[player_cell].setup(place_cards[player_cell].card_data, GC.PLACE)
	if data in places_pos:
		place_cards[player_cell]._on_button_select_mouse_button_left()
	else:
		EventBus.all_menus_close.emit()

func on_delete_place(place_data):
	# Найти и удалить карточку
	for cell in place_cards:
		if place_cards[cell].card_data == place_data:
			despawn_place_card(cell)
			break
