extends Node

func start_auto_battle(player_data: EntityData, enemy_data: EntityData):
	print("⚔️ Бой начинается: ", player_data.name, " vs ", enemy_data.name)
	
	# Работаем напрямую с данными
	while player_data.current_hp > 0 and enemy_data.current_hp > 0:
		if player_data.current_hp <= 0:
			break
		# Игрок атакует
		enemy_data.current_hp -= player_data.damage  
		print(player_data.name, " атакует: -", player_data.damage, " HP")
		# Враг атакует
		player_data.current_hp -= enemy_data.damage
		print(enemy_data.name, " атакует: -", enemy_data.damage, " HP")
	var victory = player_data.current_hp > 0
	
	if victory:
		print("✅ ПОБЕДА! +", enemy_data.food, " еды")
		add_loot(player_data, enemy_data)
		player_data.food += enemy_data.food
		#player_data.position += 1
	else:
		print("❌ ПОРАЖЕНИЕ!")
		player_data.current_hp = max(0, player_data.current_hp)
		EventBus.object_died.emit(player_data)
	return victory

func add_loot(player: EntityData, enemy: EntityData):
	for enemy_stack in enemy.inv.real_inv:
		var found: bool = false
		# Ищем такой же стак у игрока
		for player_stack in player.inv.real_inv:
			if player_stack.can_merge_with(enemy_stack):
				player_stack.merge(enemy_stack)
				found = true
				break
		# Если не нашли - добавляем копию
		if not found:
			player.inv.real_inv.append(enemy_stack.duplicate())
	EventBus.player_changed.emit(player)
