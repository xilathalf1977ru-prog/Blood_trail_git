extends Button
## ХРАНИТ ДАННЫЕ
@export var data: Texture
## СИГНАЛЫ ОТДАТЬ И ВЗЯТЬ
signal pick_item
signal place_item
## ФУНКЦИЯ ЗАПУСКА 1 РАЗ ОТ ЗАГРУЗКИ УЗЛА
func _ready() -> void:
	## ВЫЗОВ ФУНКЦИИ ОБНОВИТЬ КАРТИНКУ
	ui_update()
## ФУНКЦИЯ ОБНОВИТЬ КАРТИНКУ
func ui_update() -> void:
	if data:## ЕСЛИ ЕСТЬ ДАННЫЕ
		## УСТАНАВЛИВАЕТ КАРТИНКУ НА ТЕКСТУРРЕКТ
		$TextureRect.texture = data
	else:## ЕСЛИ НЕТУ ДАННЫХ
		## ДЕЛАЕТ ПУСТЫМ ТЕКСТУРРЕКТ
		$TextureRect.texture = null
## ЗАПУСКАЕТСЯ ОТ НАЖАТИЯ
func _on_pressed() -> void:
	if data:## ЕСЛИ ЕСТЬ ДАННЫЕ
		## СИГНАЛ ОТДАТЬ ИХ
		pick_item.emit(data, name)
	else:## ЕСЛИ НЕТУ ДАННЫХ
		## СИГНАЛ ВЗЯТЬ ИХ
		place_item.emit(name)
