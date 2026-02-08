extends Control

const DISTANCE_TEXT :String = "Шаги от дома: %d"
#var local_player_data :EntityData
func _ready():
	EventBus.player_changed.connect(on_player_changed)
func on_player_changed(_player_data: EntityData):
	#local_player_data = player_data
	#$HomeDistanceLabel.text = DISTANCE_TEXT % player_data.steps
	pass


func _on_inventory_button_pressed() -> void:
	#EventBus.menu.emit(local_player_data, GC.Act.MY_INV)
	EventBus.menu.emit(GameManager.player_ref.data.inv, GC.Act.MY_INV)
	#GameManager.player_ref.data.actions[0]
