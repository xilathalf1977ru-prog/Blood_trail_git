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
			EventBus.log_show.emit(TR.lc("Enemy attacked:") + " " + enemy.name)
			BattleManager.start_auto_battle(player, enemy)
			#EventBus.log_show.emit("Напал враг " + enemy.name)
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
			EventBus.time_tick.emit(1)
		GC.Act.EQUIP: EventBus.player_equip_change.emit(data)
func heal(data: Resource, n: int = 1) -> void:
	player.current_hp = min(player.current_hp + data.heal_amount * n, player.max_hp)
	EventBus.player_changed.emit(player)
	EventBus.log_show.emit(TR.lc("Cured by:") + " " + str(data.heal_amount * n))

func add_loot(to_inv: Resource, from_inv: Resource):
	for item in from_inv.inv.real_inv:
		if item.name == "Sword wolfkiller":
			EventBus.log_show.emit(TR.lc("Quest is completed"))
			EventBus.quest_finished.emit()
		EventBus.log_show.emit(TR.lc("You received item:") + " " + item.name)
		add_item(to_inv, item)
	EventBus.sfx.emit("loot")
	EventBus.player_changed.emit(to_inv)


func add_item(to_inv, item):
	var found: bool = false
	for player_stack in to_inv.inv.real_inv:#Ищем такой же стак у игрока
		if player_stack.can_merge_with(item):
			player_stack.merge(item)
			found = true
			break
	if not found:#Если не нашли - добавляем копию
		to_inv.inv.real_inv.append(item.duplicate())
