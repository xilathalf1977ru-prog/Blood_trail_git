extends Node

## --- СИСТЕМНЫЕ / ПЕРЕКЛЮЧЕНИЕ ЭКРАНОВ ---
@warning_ignore("unused_signal")
signal main_menu_changed(vis: bool)
@warning_ignore("unused_signal")
signal death_screen_changed(vis: bool)
@warning_ignore("unused_signal")
signal menu(data: Resource, context: String)
@warning_ignore("unused_signal")
signal check_all_menus_closed()
@warning_ignore("unused_signal")
signal all_menus_close()

@warning_ignore("unused_signal")
signal resource_init()


## --- ЖИЗНЕННЫЙ ЦИКЛ СЕССИИ ---
@warning_ignore("unused_signal")
signal loading()          # начало загрузки уровня/сессии
@warning_ignore("unused_signal")
signal save()             # запрос на сохранение
@warning_ignore("unused_signal")
signal cleanup_game()     # запрос на очистку игрового мира
@warning_ignore("unused_signal")
signal place_visibility_changed(cell: int, place_data: PlaceData, show: bool)
@warning_ignore("unused_signal")
signal player_at_place(place_data: PlaceData, vis: bool)

## --- ГЕНЕРАЦИЯ КОНТЕНТА ---
@warning_ignore("unused_signal")
signal enemies_generated(enemies: Array[EntityData])

## --- СОСТОЯНИЕ ИГРОКА ---
@warning_ignore("unused_signal")
signal player_changed(player_data: EntityData)

## --- ДЕЙСТВИЯ ИГРОКА ---
@warning_ignore("unused_signal")
signal player_move(direction: Vector2)
@warning_ignore("unused_signal")
signal player_moved(steps: int)

## --- ВЗАИМОДЕЙСТВИЕ С СУЩНОСТЯМИ ---
@warning_ignore("unused_signal")
signal card_selected(data: Resource, direction: Vector2)
@warning_ignore("unused_signal")
signal card_details_requested(data: Resource)

## --- СМЕРТЬ И УДАЛЕНИЕ ---
@warning_ignore("unused_signal")
signal object_died(obj: Resource)  # обобщённый сигнал (можно уточнить тип позже)
