extends Control

var n: int = 1: 
	set(new_value):
		n = new_value
		$Background/NText.text = str(n)
var n_max: int = 6
var local_buffer: Array = []
func _ready() -> void:
	$Background/ButtonCancel.pressed.connect(_on_cancel)
	$Background/NText.text = str(n)
	$Background/ButtonMin.pressed.connect(_on_min_n)
	$Background/ButtonHalf.pressed.connect(_on_half_max_n)
	$Background/ButtonMax.pressed.connect(_on_max_n)
	$Background/ButtonOK.pressed.connect(_on_ok)
	EventBus.show_quantity_menu.connect(on_show)
func on_show(vis, n_max_import, buffer):
	local_buffer = buffer
	n_max = n_max_import
	n = 1
	visible = vis
func _on_select_n_minus():
	if n > 1:
		n -=1
func _on_select_n_plus():
	if n < n_max:
		n +=1
func _on_min_n():
	n = 1
func _on_half_max_n():
	@warning_ignore("integer_division")
	n = (n_max + 1)/2
func _on_max_n():
	n = n_max

func _on_cancel():
	visible = false
	EventBus.result_quantity_menu.emit(0, [])
func _on_ok():
	visible = false
	EventBus.result_quantity_menu.emit(n, local_buffer)
