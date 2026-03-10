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
	
	EventBus.alert_show.connect(on_alert_show)
	
	if $History.visible:
		$AudioStreamPlayer.stream = Sound["voice"]
	else:
		$AudioStreamPlayer.stream = Sound["theme"]
	$AudioStreamPlayer.play()
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

var quest_finished: bool = false
func on_show_quest() -> void:
	$History.visible = true
	if $History.visible:
		if !quest_finished:
			$AudioStreamPlayer.stream = Sound["voice"]
		elif quest_finished:
			$AudioStreamPlayer.stream = Sound["voice2"]
	else:
		$AudioStreamPlayer.stream = Sound["theme"]
	$AudioStreamPlayer.play()
func on_quest_finished() -> void:
	quest_finished = true
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
const ALERTS: Dictionary = {
	"sleep": preload("res://Voice/alert_sleep.mp3"),
	"teleport_rng": preload("res://Voice/alert_portal.mp3"),
}
var alert_name_local: String = ""
var alert_res_local: Resource = null
func on_alert_show(alert_name: String, alert_res: Resource = null) -> void:
	alert_name_local = alert_name
	alert_res_local = alert_res
	GC.control_free = false
	if alert_name_local == GC.Act.SLEEP:
		$Alert/Label.text = "
			Спать на тропе это риск! Ты исцелишься, 
			но опасный враг может напасть.
			
			Рискнёшь?
		"
	elif alert_name_local == GC.Act.TELEPORT_RNG:
		$Alert/Label.text = "
			Портал это риск!
			
			Он телепортирует тебя.
			Но опасный враг может напасть.
			
			Рискнёшь?
		"
	$Alert.visible = true
	$Alert/Audio.stream = ALERTS[alert_name]
	$Alert/Audio.play()
func _on_alert_no_pressed() -> void:
	alert_name_local = ""
	alert_res_local = null
	GC.control_free = true
	$Alert.visible = false
	$Alert/Audio.stop()
	$Alert/Audio.stream = null
func _on_alert_yes_pressed() -> void:
	if alert_name_local == GC.Act.SLEEP:
		const SLEEP_DATA: ActionData = preload("res://Data/Actions/sleep.tres")
		ActionManager.handle_action(SLEEP_DATA, GC.Act.HEAL)
		ActionManager.handle_action(null, GC.Act.RANDOM_ATTACK)
	elif alert_name_local == GC.Act.TELEPORT_RNG:
		var dist: int = GC.rng.randi_range(alert_res_local.dist*-1, alert_res_local.dist)
		EventBus.player_teleport.emit(dist)
		EventBus.all_menus_close.emit()
		EventBus.sfx.emit("portal")
		EventBus.log_show.emit("Телепортировался на " + str(dist))
	_on_alert_no_pressed()
