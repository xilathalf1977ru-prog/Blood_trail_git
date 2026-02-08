extends Button

var timer: float = 0.0
@export var interval: float = 0.2  # Интервал в секундах
@export var plus: bool = false
func _ready() -> void:
	set_process(false)
func _on_button_down() -> void:
	action()
	set_process(true)
func _on_button_up() -> void:
	set_process(false)
	timer = 0.0
func _process(delta: float) -> void:
	timer += delta
	if timer >= interval:
		timer = 0.0
		#print("Сработало каждые ", interval, " секунд")
		action()
func action() -> void:
	if plus:
		print("YES")
		#get_parent().get_parent()._on_select_n_plus()
	else:
		pass
		#get_parent().get_parent()._on_select_n_minus()
