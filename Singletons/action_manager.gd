extends Node

func handle_action(data: Resource, context: String):
	var player: EntityData = GameManager.player_ref.data
	match context:
		GC.Act.HEAL:
			player.current_hp = min(player.current_hp + data.heal_amount, player.max_hp)
			EventBus.player_changed.emit(player)
		GC.Act.TRADE:
			EventBus.menu.emit(data, GC.Act.TRADE)
		GC.Act.INV:
		#	print_debug(data.type)
			EventBus.menu.emit(data, GC.Act.INV)
