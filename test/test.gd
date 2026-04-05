extends Node2D


func _ready() -> void:
	$AudioStreamPlayer.stream = preload("res://Music/e.ogg")
	$AudioStreamPlayer.play()
	#await get_tree().create_timer(5.0).timeout
	#$AudioStreamPlayer.stream_paused = true
	#await get_tree().create_timer(5.0).timeout
	#$AudioStreamPlayer.stream_paused = false
