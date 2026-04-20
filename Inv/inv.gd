extends Control

@export var menus: Array[ColorRect]
@export var player_data: Resource

func _ready() -> void:
	EventBus.inv.connect(show_inv)
func show_inv(context: String, data: Resource, _data2: Resource = null):
	if context == GC.Act.INV:
		menus[0].setup(data)
		print("Просто инвентарь")
	elif context == GC.Act.TRADE:
		print("Торговля")
	visible = true
func _on_button_exit_pressed() -> void:
	visible = false
