extends CanvasLayer

const SOUND: Dictionary[String, AudioStream] = {
	"theme":preload("res://Music/e.ogg"),
}
var story_step: int = 0
func _ready() -> void:
	EventBus.death_screen_changed.connect(show_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	EventBus.show_quest.connect(on_show_quest)
	EventBus.quest_finished.connect(on_quest_finished)
	set_quest_info()
	if !$History.visible:
		$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
func show_death_screen(vis :bool):
	$DeathScreen.visible = vis
func show_main_menu(vis :bool): $MainMenu.visible = vis
func _on_button_close_pressed() -> void:
	GC.control_free = true
	$History.visible = false
	$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
func on_show_quest() -> void:
	#GC.control_free = false
	$History.visible = true
	if $History.visible:
		set_quest_info()
	else:
		$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
func set_quest_info() -> void:
	#GC.control_free = false
	$History.visible = true
	if story_step == 0:
		$History/Label2.text = TR.lc("quest0")
		$AudioStreamPlayer.stream = TR.alc("quest0_voice")
	elif story_step == 1:
		$History/Label2.text = TR.lc("quest1")
		$AudioStreamPlayer.stream = TR.alc("quest1_voice")
	elif story_step == 2:
		$History/Label2.text = TR.lc("quest2")
	elif story_step == 3:
		$History/Label2.text = TR.lc("quest3")
	if story_step != 0:
		$History/TextureRect.visible = false
		$History/TextureRect2.visible = false
	GC.control_free = false
func on_quest_finished(n: int) -> void:
	if n > story_step:
		GC.control_free = false
		story_step = n
		set_quest_info()
		$AudioStreamPlayer.play()
		$History.visible = true
