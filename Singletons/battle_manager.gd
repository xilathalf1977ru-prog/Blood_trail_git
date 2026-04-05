extends Node

func start_auto_battle(player_data: EntityData, enemy_data: EntityData):
	#print("⚔️ Бой начинается: ", player_data.name, " vs ", enemy_data.name)
	EventBus.sfx.emit("attack")
	# Работаем напрямую с данными
	while player_data.current_hp > 0 and enemy_data.current_hp > 0:
		if player_data.current_hp <= 0:
			break
		# Игрок атакует
		enemy_data.current_hp -= max(1, player_data.damage - max(0, enemy_data.armor))
		player_data.current_hp -= max(1, enemy_data.damage - max(0, player_data.armor))
	var victory = player_data.current_hp > 0
	
	if victory:
		if enemy_data.name == "Wolf":
			EventBus.quest_finished.emit(2)
		if enemy_data.name == "Witch":
			EventBus.quest_finished.emit(10)
		EventBus.log_show.emit(TR.lc("Enemy killed:") + " " + TR.lc(enemy_data.name))
		
		ActionManager.add_loot(player_data, enemy_data)
	else:
		EventBus.sfx.emit("dead")
		#for i in player_data.equip_slots.keys():
			#EventBus.check_equip.emit(player_data.equip_slots[i])
		#player_data.real_inv.clear()
		#player_data.steps = 0
		#player_data.armor = 0
		#player_data.damage = 10
		#player_data.max_hp = 100
		#player_data.current_hp = max(0, player_data.current_hp)
		EventBus.object_died.emit(player_data)
		EventBus.log_show.emit(TR.lc("You killed by:") + " " + TR.lc(enemy_data.name))
	return victory
