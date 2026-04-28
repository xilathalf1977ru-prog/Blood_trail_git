extends Control

const LIMIT_BLICK: float = 0.51
var item: Resource

func _ready() -> void:
	EventBus.player_changed.connect(on_player_changed)
func _on_button_inv_pressed() -> void:
	#EventBus.menu.emit(GameManager.player_ref.data, GC.Act.INV)
	#var arr: Array[Resource] = [GameManager.player_ref.data]
	
	EventBus.inv.emit(GC.Act.INV, [GameManager.player_ref.data])
	
func _on_button_sleep_pressed() -> void:
	EventBus.alert_show.emit(GC.Act.SLEEP)
func on_player_changed(data: Resource) -> void:
	$TextureProgressBar.max_value = data.max_hp
	$TextureProgressBar.value = data.current_hp
	$HP.text = str(data.current_hp) + "/" + str(data.max_hp)
	$Damage/L.text = str(data.damage)
	$Armor/L.text = str(data.armor)
	if float(data.current_hp) >= (data.max_hp * LIMIT_BLICK):
		if $Timer.timeout.is_connected(_on_timer_timeout):
			$Timer.stop()
			$Timer.timeout.disconnect(_on_timer_timeout)
		$TextureProgressBar.visible = true
		$ButtonHeal.visible = false
	else:
		if !$Timer.timeout.is_connected(_on_timer_timeout):
			$Timer.timeout.connect(_on_timer_timeout)
			$Timer.start()
		if data.real_inv2.has("Elixir HP 50"):
			item = data.real_inv2["Elixir HP 50"]
			$ButtonHeal.visible = true
func _on_timer_timeout() -> void:
	$TextureProgressBar.visible = !$TextureProgressBar.visible
func _on_button_quest_pressed() -> void:
	EventBus.show_quest.emit()
func _on_button_exit_pressed() -> void:
	get_tree().quit()
func _on_button_heal_pressed() -> void:
	if item:
		EventBus.sfx.emit("drink")
		ActionManager.handle_action(item, GC.Act.HEAL, 1)
		ActionManager.player.reduce_item(item, 1)
