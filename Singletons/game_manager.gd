extends Node

var player_ref: Node
var pending_save_data: SaveData
var current_enemies: Array[EntityData]
var invs: Dictionary[String, Array]
var invs_money: Dictionary[String, int]

func _ready() -> void:
	EventBus.card_selected.connect(on_selected)
	EventBus.card_details_requested.connect(details_requested)
	EventBus.object_died.connect(on_object_died)
	EventBus.save.connect(save_game)
	EventBus.player_moved.connect(on_player_moved)
	#call_deferred("resource_init")
#func resource_init():
	#EventBus.resource_init.emit()
func save_game() -> void:
	if player_ref:
		SaveSystem.save_game(
			player_ref.data,
			current_enemies,
			invs,
			invs_money
			)
	else:push_warning("GameManager: save requested, but player_data is null")
func load_game():
	var save_data = SaveSystem.load_game()
	if not save_data:
		return false
	if player_ref:  # Если игрок уже зарегистрирован
		player_ref.load_data(save_data.player_data.duplicate())
		EventBus.player_moved.emit(player_ref.data.steps)
		EventBus.enemies_generated.emit(save_data.enemies)
		for i in save_data.invs.size():
			var inv = load(save_data.invs.keys()[i])
			inv.real_inv = save_data.invs.values()[i]
		for i in save_data.invs_money.size():
			var inv = load(save_data.invs_money.keys()[i])
			inv.money = save_data.invs_money.values()[i]
		print("✅ Игра загружена")
	else:  # Если игрок ещё не готов
		pending_save_data = save_data
		print("⏳ Сохранение загружено, ждём игрока...")
	return true
func register_player(player: Node):
	player_ref = player
	print("✅ Игрок зарегистрирован в GameManager")# Если есть ожидающее сохранение - загружаем
	current_enemies = EnemyManager.generate_enemies(6)
	if pending_save_data:
		player.load_data(pending_save_data.player_data)
		pending_save_data = null
		print("✅ Сохранение применено к игроку")
func on_player_moved(_steps: int):
	current_enemies = EnemyManager.generate_enemies(6)
func on_selected(data: Resource, _context: String):
	if data is EntityData:
		BattleManager.start_auto_battle(player_ref.data, data)
		EventBus.player_move.emit(data.direction)
func details_requested(_entity_data: Resource):
	pass
func on_object_died(obj):
	if obj is EntityData:
		if obj.player:
			EventBus.death_screen_changed.emit(true)
			EventBus.cleanup_game.emit()
