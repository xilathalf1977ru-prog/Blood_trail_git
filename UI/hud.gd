extends Control

const LIMIT_BLICK: float = 0.51

func _ready() -> void:
	EventBus.player_changed.connect(on_player_changed)
func _on_button_inv_pressed() -> void:
	#EventBus.menu.emit(GameManager.player_ref.data, GC.Act.INV)
	EventBus.inv.emit(GC.Act.INV, GameManager.player_ref.data)
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
	else:
		if !$Timer.timeout.is_connected(_on_timer_timeout):
			$Timer.timeout.connect(_on_timer_timeout)
			$Timer.start()
func _on_timer_timeout() -> void:
	$TextureProgressBar.visible = !$TextureProgressBar.visible
func _on_button_quest_pressed() -> void:
	EventBus.show_quest.emit()
func _on_button_exit_pressed() -> void:
	get_tree().quit()

	
