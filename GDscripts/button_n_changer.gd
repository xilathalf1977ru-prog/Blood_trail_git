extends Button

var timer: float = 0.0
@export var interval: float = 0.2  # Интервал в секундах
@export var plus: bool = false
func _ready() -> void:
	set_process(false)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
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
		action()
func action() -> void:
	if plus:
		get_parent().get_parent()._on_select_n_plus()
	else:
		get_parent().get_parent()._on_select_n_minus()
