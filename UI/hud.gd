extends Control

const DISTANCE_TEXT :String = "Шаги от дома: %d"

func _ready() -> void:
	EventBus.player_changed.connect(on_player_changed)
func _on_button_inv_pressed() -> void:
	EventBus.menu.emit(GameManager.player_ref.data.inv, GC.Act.MY_INV)

func _on_button_sleep_pressed() -> void:
	const SLEEP_DATA: ActionData = preload("res://Data/Actions/sleep.tres")
	
	ActionManager.handle_action(SLEEP_DATA, GC.Act.HEAL)
	ActionManager.handle_action(null, GC.Act.RANDOM_ATTACK)

func on_player_changed(data: Resource) -> void:
	$TextureProgressBar.max_value = data.max_hp
	$TextureProgressBar.value = data.current_hp
	$HP.text = str(data.current_hp) + "/" + str(data.max_hp)
