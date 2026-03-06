extends Node2D

func _ready() -> void:
	print($Sprite2D.position)
	
	var tween = create_tween()
	var target_pos = Vector2(625 - GC.CELL, 600 - GC.CELL*2)
	
	# Подключаем сигнал
	tween.finished.connect(_on_tween_finished)
	
	# Запускаем анимацию
	tween.tween_property($Sprite2D, "position", target_pos, 1)

func _on_tween_finished():
	print("gotovo")  # Выполнится только когда tween закончится
