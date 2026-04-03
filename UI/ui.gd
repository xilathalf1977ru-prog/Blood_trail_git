extends CanvasLayer

const SOUND: Dictionary[String, AudioStream] = {
	"theme":preload("res://Music/e.ogg"),
}
var story_step: int = 0
func _ready() -> void:
	#EventBus.death_screen_changed.connect(show_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	EventBus.show_quest.connect(on_show_quest)
	EventBus.quest_finished.connect(on_quest_finished)
	set_quest_info()
	if !$History.visible:
		$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
#func show_death_screen(vis :bool):
	#$DeathScreen.visible = vis
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
		$History/Label3.text = TR.lc("quest_s0")
		$History/QIcon1.texture = load("res://Data/Places/stone_and_sword/stone_and_sword.webp")
		$History/QIcon2.texture = null
	elif story_step == 1:
		$History/Label2.text = TR.lc("quest1")
		$AudioStreamPlayer.stream = TR.alc("quest1_voice")
		$History/Label3.text = TR.lc("quest_s1")
		$History/QIcon1.texture = load("res://Data/Entities/Enemies/wolf/wolf_0001.webp")
		$History/QIcon2.texture = null
	elif story_step == 2:
		$History/Label2.text = TR.lc("quest2")
		$History/Label3.text = TR.lc("quest_s2")
		$History/QIcon1.texture = load("res://Data/Places/store/store.webp")
		$History/QIcon2.texture = load("res://Data/Items/elixir_max_hp_10/elixir_max_hp_10.webp")
	elif story_step == 3:
		$History/Label2.text = TR.lc("quest3")
		$History/Label3.text = TR.lc("quest_s3")
		$History/QIcon1.texture = load("res://Data/Places/cave/cave.webp")
		$History/QIcon2.texture = load("res://Data/Items/strange_armor/strange_armor.webp")
	elif story_step == 4:
		$History/Label2.text = TR.lc("quest4")
		$History/Label3.text = TR.lc("quest_s4")
		$History/QIcon1.texture = load("res://Data/Items/strange_armor/strange_armor.webp")
		$History/QIcon2.texture = null
	if story_step != 0:
		$History/TextureRect.visible = false
	GC.control_free = false
func on_quest_finished(n: int) -> void:
	if n > story_step:
		GC.control_free = false
		story_step = n
		set_quest_info()
		$AudioStreamPlayer.play()
		$History.visible = true
