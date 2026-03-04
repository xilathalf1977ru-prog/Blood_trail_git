extends CanvasLayer

const Sound: Dictionary[String, AudioStream] = {
	"voice":preload("res://Voice/voice.mp3"),
	"voice2":preload("res://Voice/voice2.mp3"),
	"theme":preload("res://Music/e.mp3"),
}



func _ready() -> void:
	EventBus.death_screen_changed.connect(show_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	EventBus.show_quest.connect(on_show_quest)
	
	EventBus.quest_finished.connect(on_quest_finished)
	#on_quest_finished()
	if $History.visible:
		$AudioStreamPlayer.stream = Sound["voice"]
	else:
		$AudioStreamPlayer.stream = Sound["theme"]
	$AudioStreamPlayer.play()
	#on_quest_finished()
func show_death_screen(vis :bool):
	$DeathScreen.visible = vis
func show_main_menu(vis :bool):$MainMenu.visible = vis


func _on_button_close_pressed() -> void:
	$History.visible = false
	
	if $History.visible:
		$AudioStreamPlayer.stream = Sound["voice"]
	else:
		$AudioStreamPlayer.stream = Sound["theme"]
	$AudioStreamPlayer.play()

func on_show_quest() -> void:
	$History.visible = true
	
	if $History.visible:
		$AudioStreamPlayer.stream = Sound["voice"]
	else:
		$AudioStreamPlayer.stream = Sound["theme"]
	$AudioStreamPlayer.play()
func on_quest_finished() -> void:
	$History.visible = true
	$History/Label2.text = "Ха! Ты выполнил задание...
	Удивительно, мы думали что тебе не за что не справиться.
	Многие не смогли его выполнить, и просто ушли в мир иной.
	Ты можешь собой гордиться, 
	и можешь попробовать порубить волка в фарш, 
	этим славным мечом, если ты полностью здоров."
	$AudioStreamPlayer.stream = Sound["voice2"]
	$AudioStreamPlayer.play()
	$History/TextureRect.visible = false
	$History/TextureRect2.visible = false
