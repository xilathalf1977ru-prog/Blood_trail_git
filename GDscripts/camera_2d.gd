extends Camera2D

func _ready() -> void:
	#EventBus.player_changed.connect(on_position_changed)
	EventBus.camera_move.connect(_on_camera_move)
#func _on_camera_move(target_pos):
	#var tween = create_tween()
	#tween.tween_property(self, "position:x", target_pos, 0.2)
	#
func _on_camera_move(target_pos: float, smooth: bool = true):
	if smooth:
		var tween = create_tween()
		# Плавное перемещение
		tween.tween_property(self, "position:x", target_pos, GC.anim_speed)
	else:
		# Резкое (мгновенное) перемещение
		position.x = target_pos
