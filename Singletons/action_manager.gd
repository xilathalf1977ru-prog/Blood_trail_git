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
			var enemy_pool: Array = EnemyManager.enemy_templates.duplicate_deep()
			var enemy: EntityData = enemy_pool[GC.rng.randi_range(0, enemy_pool.size()-1)]
			BattleManager.start_auto_battle(player, enemy)
			EventBus.log_show.emit("Напал враг " + enemy.name)
			GameManager.current_enemies = EnemyManager.generate_enemies(6)
		GC.Act.TELEPORT_RNG:
			#var dist: int = GC.rng.randi_range(data.dist*-1, data.dist)
			#EventBus.player_teleport.emit(dist)
			#EventBus.all_menus_close.emit()
			#EventBus.sfx.emit("portal")
			#EventBus.log_show.emit("Телепортировался на " + str(dist))
			EventBus.alert_show.emit(GC.Act.TELEPORT_RNG, data)
			
			
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
		
		EventBus.log_show.emit("Вы получили предмет: " + enemy_stack.name)
		
		if enemy_stack.name == "Волкодав":
			EventBus.log_show.emit("Задание выполнено")
			EventBus.quest_finished.emit()
		
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
	
	EventBus.sfx.emit("loot")
	EventBus.player_changed.emit(player_local)
