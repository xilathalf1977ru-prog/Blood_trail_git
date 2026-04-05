extends Control

var alert_name_local: String = ""
var alert_res_local: Resource = null
func _ready() -> void:
	EventBus.alert_show.connect(on_alert_show)
func on_alert_show(alert_name: String, alert_res: Resource = null) -> void:
	alert_name_local = alert_name
	alert_res_local = alert_res
	GC.control_free = false
	$Entity.visible = false
	$Entity2.visible = false
	$Audio.stream = TR.alc(alert_name)
	if alert_name_local == GC.Act.SLEEP:
		$Label.text = TR.lc("alert_sleep")
	elif alert_name_local == GC.Act.TELEPORT_RNG:
		$Label.text = TR.lc("alert_portal")
	elif alert_name_local == GC.Act.ROB:
		EventBus.all_menus_close.emit()
		$Label.text = TR.lc("alert_rob")
		if alert_res.name == "Cave":
			$Label.text = TR.lc("alert_cave")
			$Audio.stream = TR.alc(alert_res.name)
		elif alert_res.name == "Tower":
			$Label.text = TR.lc("alert_tower")
			$Audio.stream = TR.alc(alert_res.name)
		$Entity.visible = true
		$Entity2.visible = true
		$Entity.setup(ActionManager.player, GC.PLAYER)
		$Entity2.setup(alert_res.entities[0], GC.PLAYER)
	visible = true
	$Audio.play()
func _on_button_x_pressed() -> void:
	alert_name_local = ""
	alert_res_local = null
	GC.control_free = true
	visible = false
	$Audio.stop()
	$Audio.stream = null
func _on_button_ok_pressed() -> void:
	if alert_name_local == GC.Act.SLEEP:
		ActionManager.heal(999, 1)
		ActionManager.handle_action(null, GC.Act.RANDOM_ATTACK)
		EventBus.time_tick.emit(1)
		EventBus.player_moved.emit(ActionManager.player.position)
	elif alert_name_local == GC.Act.TELEPORT_RNG:
		var dist: int = GC.rng.randi_range(alert_res_local.dist*-1, alert_res_local.dist)
		EventBus.player_teleport.emit(dist)
		EventBus.all_menus_close.emit()
		EventBus.sfx.emit("portal")
		EventBus.log_show.emit(TR.lc("Teleported to:") + " " + str(dist))
	elif alert_name_local == GC.Act.ROB:
		var enemy = alert_res_local.entities[0]
		BattleManager.start_auto_battle(ActionManager.player, enemy.duplicate())
		ActionManager.add_loot(ActionManager.player, alert_res_local)
		ActionManager.player.money += alert_res_local.money
		alert_res_local.money = 0
		alert_res_local.real_inv.clear()
	_on_button_x_pressed()
