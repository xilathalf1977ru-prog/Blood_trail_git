extends Node2D

func _ready() -> void:
	
	await get_tree().create_timer(3).timeout
	fade_out($Sprite2D, GC.anim_speed*4)
	
	
func fade_out(node, duration: float = GC.anim_speed):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)
	tween.tween_callback(func(): node.visible = false)
	await tween.finished
func fade_in(node, duration: float = GC.anim_speed):
	node.visible = true
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)
	await tween.finished
