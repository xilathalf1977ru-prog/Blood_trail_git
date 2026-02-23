extends Node2D

var place_cards = {}  # cell: card_node
var entities: Array[Node2D]
var current_enemies_pos: Dictionary[Vector2, Resource] = {}
func _ready() -> void:
	EventBus.enemies_generated.connect(show_enemies_cards)
	EventBus.cleanup_game.connect(on_cleanup_game)
	EventBus.place_visibility_changed.connect(on_place_visibility_changed)
	EventBus.player_horizontal_moved.connect(on_player_moved)
	
	
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
	EnemyManager.generate_enemies(6)
func on_place_visibility_changed(cell: int, place_data: Resource, vis: bool):
	
	if vis:
		spawn_place_card(cell, place_data)
	else:
		despawn_place_card(cell)

func spawn_place_card(cell: int, data: PlaceData):
	if place_cards.has(cell):
		return  # Уже существует
	
	# Создаем карточку места
	var card_scene = preload("res://UI/card.tscn")
	var card = card_scene.instantiate()
	
	# Позиционируем в мировых координатах
	card.position = Vector2(-125 + (cell * GC.CELL), GC.CELL_Y[2]-100) # Настрой под свои размеры клеток
	card.setup(data, GC.FAR_PLACE)
	
	add_child(card)
	move_child(card, 4)
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
	#print_debug(GameManager.player_ref.data.steps)
	if GameManager.player_ref.data.steps % 2 != 0:
		return
	
	for i in min(enemies.size(), entities.size()):
		var enemy_data = enemies[i]
		var card = entities[i]
		@warning_ignore("integer_division")
		if i > (entities.size()-1)/2:
			card.position.x = GameManager.player_ref.data.position.x + GC.CELL
			card.position.y = GC.CELL_Y[enemy_data.direction.y+1]
			current_enemies_pos[card.position] = enemy_data
		else:
			card.position.x = GameManager.player_ref.data.position.x - GC.CELL
			card.position.y = GC.CELL_Y[enemy_data.direction.y+1]
			current_enemies_pos[card.position] = enemy_data
		card.setup(enemy_data, GC.ENEMY)
func on_player_moved(data):
	#print_debug("2")
	
	if data in current_enemies_pos.keys():
		BattleManager.start_auto_battle(GameManager.player_ref.data, current_enemies_pos[data])
	var player_cell: int = data.x/GC.CELL
	for i in place_cards.keys():
		place_cards[i].setup(place_cards[i].card_data, GC.FAR_PLACE)
	if player_cell in place_cards.keys():
		place_cards[player_cell].setup(place_cards[player_cell].card_data, GC.PLACE)
