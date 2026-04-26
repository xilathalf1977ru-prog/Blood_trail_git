extends Node

var player: EntityData:
	get:
		return GameManager.player_ref.data
func handle_action(data: Resource, context: String, n: int = 1) -> void:
	match context:
		GC.Act.HEAL: heal(data.heal_amount, n)
		GC.Act.TRADE: 
			EventBus.menu.emit(data, GC.Act.TRADE)
			EventBus.inv.emit(GC.Act.TRADE, [player, data])
		GC.Act.INV:
			EventBus.menu.emit(data, GC.Act.INV)
			EventBus.inv.emit(GC.Act.INV, [player, data])
		GC.LOOT:
			add_loot(player, data)
			
			EventBus.delete_place.emit(data)
		GC.Act.ROB: EventBus.alert_show.emit(context, data)
		GC.Act.RANDOM_ATTACK:
			var enemy: EntityData = EnemyManager._create_random_enemy()
			enemy.on_resource_init()
			EventBus.log_show.emit(TR.lc("Enemy attacked:") + " " + TR.lc(enemy.name))
			BattleManager.start_auto_battle(player, enemy)
			GameManager.current_enemies = EnemyManager.generate_enemies(6)
		GC.Act.TELEPORT_RNG:
			#var dist: int = GC.rng.randi_range(data.dist*-1, data.dist)
			#EventBus.player_teleport.emit(dist)
			#EventBus.all_menus_close.emit()
			#EventBus.sfx.emit("portal")
			#EventBus.log_show.emit("Телепортировался на " + str(dist))
			EventBus.alert_show.emit(context, data)
		GC.Act.SLEEP:
			heal(999, n)
			GameManager.current_enemies = EnemyManager.generate_enemies(6)
			EventBus.time_tick.emit(1)
		GC.Act.EQUIP: EventBus.player_equip_change.emit(data)
		GC.Act.BONUS: change_stats(data.single_bonus, 1)
func heal(heal_amount: int, n: int = 1) -> void:
	player.current_hp = min(player.current_hp + heal_amount * n, player.max_hp)
	EventBus.player_changed.emit(player)
	EventBus.log_show.emit(TR.lc("Cured by:") + " " + str(heal_amount * n))
func add_loot(to_inv: Resource, from_inv: Resource):
	for item in from_inv.real_inv2.values():
		if item.name == "Sword wolfkiller":
			EventBus.quest_finished.emit(1)
		elif item.name == "Strange armor":
			EventBus.quest_finished.emit(4)
		EventBus.log_show.emit(TR.lc("You received item:") + " " + TR.lc(item.name))
		to_inv.add_item(item, 1)
	EventBus.sfx.emit("loot")
	EventBus.player_changed.emit(to_inv)
func change_stats(stat_values, direction):
	for i in stat_values.keys():
		match i:
			"damage": player.damage += (stat_values[i]) * direction
			"armor": player.armor += (stat_values[i]) * direction
			"max_hp": player.max_hp += (stat_values[i]) * direction
	if player.max_hp >= 130:
		EventBus.quest_finished.emit(3)
	EventBus.player_changed.emit(player)
