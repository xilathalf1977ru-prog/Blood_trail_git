extends Control

@export var CD: float = 5.0
const LIMIT: int = 20
var arr_log: Array[String] = []
var slot: PackedScene = preload("res://UI/log_label.tscn")
var path: VBoxContainer
func _ready() -> void:
	path = $ScrollContainer/VBoxContainer
	EventBus.log_show.connect(on_log_show)
func on_log_show(sent_text):
	if arr_log.size() == LIMIT:
		path.get_node(arr_log[0]).queue_free()
		arr_log.erase(arr_log[0])
	var l = slot.instantiate()
	l.text = sent_text
	l.name = str(arr_log.size())
	path.add_child(l)
	arr_log.append(l.name)
	$Timer.wait_time = CD
	$Timer.start()
	await get_tree().process_frame
	$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
func _on_timer_timeout() -> void:
	path.get_node(arr_log[0]).queue_free()
	arr_log.erase(arr_log[0])
	if arr_log.size() == 0: $Timer.stop()
