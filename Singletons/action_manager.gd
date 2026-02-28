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
		GC.LOOT:
			
			#player.inv.real_inv += data.inv.real_inv
			add_loot(player, data)
			
			EventBus.delete_place.emit(data)
			#EventBus.all_menus_close.emit()
			
			
		GC.Act.RANDOM_ATTACK:
			var enemy_pool: Array[EntityData] = GameManager.current_enemies
			for i in enemy_pool:
				print(i.name)
			var enemy: EntityData = enemy_pool[GC.rng.randi_range(0, enemy_pool.size()-1)]
			BattleManager.start_auto_battle(player, enemy)
			EventBus.log_show.emit("Напал враг " + enemy.name)
			GameManager.current_enemies = EnemyManager.generate_enemies(6)
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

func add_loot(player_local: EntityData, enemy: Resource):
	for enemy_stack in enemy.inv.real_inv:
		var found: bool = false
		# Ищем такой же стак у игрока
		for player_stack in player_local.inv.real_inv:
			if player_stack.can_merge_with(enemy_stack):
				player_stack.merge(enemy_stack)
				found = true
				break
		# Если не нашли - добавляем копию
		if not found:
			player_local.inv.real_inv.append(enemy_stack.duplicate())
	EventBus.player_changed.emit(player_local)
