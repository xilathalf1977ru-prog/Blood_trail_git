extends CanvasLayer

const SOUND: Dictionary[String, AudioStream] = {
	"theme":preload("res://Music/e.ogg"),
}
func _ready() -> void:
	EventBus.death_screen_changed.connect(show_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	EventBus.show_quest.connect(on_show_quest)
	EventBus.quest_finished.connect(on_quest_finished)
	
	EventBus.alert_show.connect(on_alert_show)
	set_quest_info()
	if !$History.visible:
		$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
func show_death_screen(vis :bool):
	$DeathScreen.visible = vis
func show_main_menu(vis :bool):$MainMenu.visible = vis


func _on_button_close_pressed() -> void:
	$History.visible = false
	$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
var quest_finished: bool = false
func on_show_quest() -> void:
	$History.visible = true
	if $History.visible:
		set_quest_info()
	else:
		$AudioStreamPlayer.stream = SOUND["theme"]
	$AudioStreamPlayer.play()
	
func set_quest_info() -> void:
	if !quest_finished:
		$History/Label2.text = TR.lc("quest1")
		$AudioStreamPlayer.stream = TR.alc("voice")
	else:
		$History/Label2.text = TR.lc("quest1_end")
		$AudioStreamPlayer.stream = TR.alc("voice2")
		$History/TextureRect.visible = false
		$History/TextureRect2.visible = false
func on_quest_finished() -> void:
	quest_finished = true
	set_quest_info()
	$AudioStreamPlayer.play()
	$History.visible = true
var alert_name_local: String = ""
var alert_res_local: Resource = null
func on_alert_show(alert_name: String, alert_res: Resource = null) -> void:
	alert_name_local = alert_name
	alert_res_local = alert_res
	GC.control_free = false
	if alert_name_local == GC.Act.SLEEP:
		$Alert/Label.text = TR.lc("alert_sleep")
	elif alert_name_local == GC.Act.TELEPORT_RNG:
		$Alert/Label.text = TR.lc("alert_portal")
	$Alert.visible = true
	$Alert/Audio.stream = TR.alc(alert_name)
	$Alert/Audio.play()
func _on_button_x_pressed() -> void:
	alert_name_local = ""
	alert_res_local = null
	GC.control_free = true
	$Alert.visible = false
	$Alert/Audio.stop()
	$Alert/Audio.stream = null
func _on_button_ok_pressed() -> void:
	if alert_name_local == GC.Act.SLEEP:
		const SLEEP_DATA: ActionData = preload("res://Data/Actions/sleep.tres")
		ActionManager.handle_action(SLEEP_DATA, GC.Act.SLEEP)
		ActionManager.handle_action(null, GC.Act.RANDOM_ATTACK)
	elif alert_name_local == GC.Act.TELEPORT_RNG:
		var dist: int = GC.rng.randi_range(alert_res_local.dist*-1, alert_res_local.dist)
		EventBus.player_teleport.emit(dist)
		EventBus.all_menus_close.emit()
		EventBus.sfx.emit("portal")
		EventBus.log_show.emit("Телепортировался на " + str(dist))
	_on_button_x_pressed()
