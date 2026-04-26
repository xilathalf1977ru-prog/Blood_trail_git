extends ColorRect
## ХРАНИТ ДАННЫЕ
var local_data: Texture
## СТОП ФУНКЦИИ ПРОЦЕСС ПРИ СТАРТЕ 
func _ready() -> void:
	_process(false)
## ФУНКЦИЯ ЗАГРУЗКА ДАННЫХ
func download(data: Texture) -> void:
	local_data = data## ЗАГРУЗКА ДАННЫХ
	## ЗАГРУЗКА КАРТИНКИ
	$TextureRect.texture = data
	visible = true## ВКЛ ВИДИМОСТИ
	_process(true)## ВКЛ ФУНКЦИИ ПРОЦЕСС
## ДЕЛАЕТ ВЫКЛ И ОБНУЛЕНИЕ
## ДЕЙСТВИЙ ФУНКЦИИ ЗАГРУЗКА ДАННЫХ
func upload() -> void:
	local_data = null
	$TextureRect.texture = null
	visible = false
	_process(false)
## ПРОЦЕСС СТАВИТ ПОЗИЦИЮ = КУРСОР МЫШИ
func _process(_delta: float) -> void:
	position = get_global_mouse_position()
