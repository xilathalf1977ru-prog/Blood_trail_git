extends Node2D
## ХРАНИТ ПУТЬ К COLORRECT
@export var loader: Node
## ПРИНИМАЕТ СИГНАЛ ОТДАТЬ BUTTON ДАННЫЕ
## ДАННЫЕ это data И ЕГО ИМЯ это id
func _on_button_pick_item(data: Texture, id: String):
	## ЕСЛИ COLORRECT ДАННЫЕ ПУСТЫЕ
	if loader.local_data == null:
		## ДЕЛАЕМ ПУСТЫМИ ДАННЫЕ BUTTON
		get_node(id).data = null
		get_node(id).ui_update()
	## ИНАЧЕ ЕСЛИ COLORRECT ДАННЫЕ ПОЛНЫЕ
	else:
		## ЗАПУСК ФУНКЦИИ ВЗЯТЬ ДАННЫЕ ДЛЯ BUTTON
		_on_button_place_item(id)
	## ЗАГРУЖАЕМ ДАННЫЕ BUTTON В COLORRECT
	loader.download(data)
## ФУНКЦИЯ ВЗЯТЬ ДАННЫЕ ДЛЯ BUTTON
func _on_button_place_item(id: String) -> void:
	## КОПИРУЕМ ДАННЫЕ COLORRECT В BUTTON
	get_node(id).data = loader.local_data
	## ЗАПУСК ОБНОВЛЕНИЯ КАРТИНКИ У BUTTON
	get_node(id).ui_update()
	## ЗАПУСК ОЧИЩЕНИЯ COLORRECT
	loader.upload()
