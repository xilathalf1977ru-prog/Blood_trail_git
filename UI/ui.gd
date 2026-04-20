extends CanvasLayer

const SOUND: Dictionary[String, AudioStream] = {
	"theme":preload("res://Music/e.ogg"),
}
func _ready() -> void:
	EventBus.death_screen_changed.connect(on_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	EventBus.show_quest.connect(on_show_quest)
	EventBus.quest_finished.connect(on_quest_finished)
	set_quest_info()
	$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
	if $History.visible:
		$AudioStreamPlayer.stream_paused = true
func show_main_menu(vis :bool): $MainMenu.visible = vis
func _on_button_close_pressed() -> void:
	GC.control_free = true
	$History.visible = false
	$History/Voice.stop()
	$History/Voice.stream = null
	$AudioStreamPlayer.stream_paused = false
func on_show_quest() -> void:
	#$History.visible = true
	if $History.visible:
		set_quest_info()
	else:
		$AudioStreamPlayer.stream = SOUND["theme"]
func set_quest_info() -> void:
	$AudioStreamPlayer.stream_paused = true
	#$History.visible = true
	if GC.story_step == 0:
		$History/Label2.text = TR.lc("quest0")
		$History/Voice.stream = TR.alc("quest0_voice")
		$History/Label3.text = TR.lc("quest_s0")
		$History/QIcon1.texture = load("res://Data/Places/stone_and_sword/stone_and_sword.webp")
		$History/QIcon2.texture = null
	elif GC.story_step == 1:
		$History/Label2.text = TR.lc("quest1")
		$History/Voice.stream = TR.alc("quest1_voice")
		$History/Label3.text = TR.lc("quest_s1")
		$History/QIcon1.texture = load("res://Data/Entities/Enemies/wolf/wolf_0001.webp")
		$History/QIcon2.texture = null
	elif GC.story_step == 2:
		$History/Label2.text = TR.lc("quest2")
		$History/Voice.stream = TR.alc("quest2_voice")
		$History/Label3.text = TR.lc("quest_s2")
		$History/QIcon1.texture = load("res://Data/Places/store/store.webp")
		$History/QIcon2.texture = load("res://Data/Items/elixir_max_hp_10/elixir_max_hp_10.webp")
	elif GC.story_step == 3:
		$History/Label2.text = TR.lc("quest3")
		$History/Voice.stream = TR.alc("quest3_voice")
		$History/Label3.text = TR.lc("quest_s3")
		$History/QIcon1.texture = load("res://Data/Places/cave/cave.webp")
		$History/QIcon2.texture = load("res://Data/Items/strange_armor/strange_armor.webp")
	elif GC.story_step == 4:
		$History/Label2.text = TR.lc("quest4")
		$History/Voice.stream = TR.alc("quest4_voice")
		$History/Label3.text = TR.lc("quest_s4")
		$History/QIcon1.texture = load("res://Data/Items/strange_armor/strange_armor.webp")
		$History/QIcon2.texture = null
	elif GC.story_step == 10:
		$History/Label2.text = TR.lc("quest10")
		$History/Voice.stream = TR.alc("quest10_voice")
		$History/End.visible = true
		$History/Label3.visible = false
		$History/QIcon1.texture = null
		$History/QIcon2.texture = null
	if GC.story_step != 0:
		$History/TextureRect.visible = false
	$History/Voice.play()
	GC.control_free = false
func on_quest_finished(n: int) -> void:
	if n > GC.story_step:
		GC.control_free = false
		GC.story_step = n
		set_quest_info()
		$History.visible = true
func on_death_screen(vis: bool, end_game: bool = false):
	if vis and end_game:
		$AudioStreamPlayer.stream = TR.alc("bad_end")
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stream = SOUND["theme"]
		$AudioStreamPlayer.play()
