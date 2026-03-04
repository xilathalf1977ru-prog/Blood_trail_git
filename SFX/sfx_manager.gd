extends Node

func _ready() -> void:
	EventBus.sfx.connect(on_sfx)
func on_sfx(sfx_name):
	var new_player: AudioStreamPlayer = AudioStreamPlayer.new()
	new_player.stream = GC.SFX[sfx_name]
	add_child(new_player)
	new_player.finished.connect(new_player.queue_free)
	new_player.play()
