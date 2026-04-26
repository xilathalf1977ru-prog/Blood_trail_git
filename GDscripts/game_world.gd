extends Node2D

const PLACE_OFFSET: Vector2 = Vector2(128, 128)
const PLACE_CARD_LAYER: int = 2
var place_cards: Dictionary[int, Node2D] = {}
@export var entities: Array[Node2D]
@export var places: Array[Node2D]
var current_enemies_pos: Dictionary[Vector2, Resource] = {}
func _ready() -> void:
	EventBus.enemies_generated.connect(show_enemies_cards)
	EventBus.cleanup_game.connect(on_cleanup_game)
	EventBus.player_moved.connect(on_player_moved)
	call_deferred("resource_init")
func resource_init():
	GameManager.current_enemies = EnemyManager.generate_enemies(6)
	on_player_moved(GameManager.player_ref.data.position)
func _on_map_places_vis(places_vis: Array) -> void:
	for i in places.size():
		if places_vis[i]:
			places[i].setup(places_vis[i], GC.PLACE)
			places[i].visible = true
		else:
			places[i].visible = false
			places[i].clear()
func on_cleanup_game():
	await get_tree().process_frame
	queue_free()
func show_enemies_cards(enemies: Array[EntityData]) -> void:
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
	$PP.position.x = data.x
	var delta: int = int(data.x) - last_posx_player
	var direct: float = sign(delta) * (1 if abs(delta) == GC.CELL else -1)
	last_posx_player += delta
	var player_key = Vector2(direct, data.y)
	if player_key in current_enemies_pos.keys():
		BattleManager.start_auto_battle(GameManager.player_ref.data, current_enemies_pos[player_key])
	
	@warning_ignore("integer_division")
	var mid_places: int = (places.size() - 1)/2
	for i in places.size():
		places[i].get_node("ButtonSelect").visible = (i == mid_places)
	if data.y == GC.cell_place_y and places[mid_places].card_data:
		places[mid_places]._on_button_select_pressed()
