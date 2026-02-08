extends Camera2D

func _ready() -> void:
	EventBus.player_changed.connect(on_position_changed)
func on_position_changed(player_data: EntityData):
	position.x = player_data.position
