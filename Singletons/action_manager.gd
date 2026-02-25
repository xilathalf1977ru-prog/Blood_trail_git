extends Node

var player: EntityData = null
func handle_action(data: Resource, context: String, n: int = 1) -> void:
	player = GameManager.player_ref.data
	match context:
		GC.Act.HEAL:
			heal(data, n)
		GC.Act.TRADE:
			EventBus.menu.emit(data, GC.Act.TRADE)
		GC.Act.INV:
			EventBus.menu.emit(data, GC.Act.INV)
		GC.Act.RANDOM_ATTACK:
			var enemy_pool: Array[EntityData] = GameManager.current_enemies
			var enemy: EntityData = enemy_pool[GC.rng.randi_range(0, enemy_pool.size()-1)]
			EnemyManager.generate_enemies(6)
			EventBus.log_show.emit("Напал враг " + enemy.name)
			BattleManager.start_auto_battle(player, enemy)
		GC.Act.TELEPORT_RNG:
			var dist: int = GC.rng.randi_range(data.dist*-1, data.dist)
			await get_tree().process_frame
			EventBus.player_move.emit(Vector2(dist, 0))
			EventBus.all_menus_close.emit()
			EventBus.log_show.emit("Телепортировался на " + str(dist))
		GC.Act.SLEEP:
			heal(data, n)
			GameManager.current_enemies = EnemyManager.generate_enemies(6)
		GC.Act.EQUIP: EventBus.player_equip_change.emit(data)
func heal(data: Resource, n: int = 1) -> void:
	player.current_hp = min(player.current_hp + data.heal_amount * n, player.max_hp)
	EventBus.player_changed.emit(player)
	EventBus.log_show.emit("Полечился на " + str(data.heal_amount * n))
