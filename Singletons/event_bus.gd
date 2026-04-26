extends Node

## --- СИСТЕМНЫЕ / ПЕРЕКЛЮЧЕНИЕ ЭКРАНОВ ---
@warning_ignore("unused_signal")
signal main_menu_changed(vis: bool)
@warning_ignore("unused_signal")
signal death_screen_changed(vis: bool)
@warning_ignore("unused_signal")
signal menu(data: Resource, context: String)
@warning_ignore("unused_signal")
signal inv(context: String, arr_res: Array)

@warning_ignore("unused_signal")
signal check_all_menus_closed()
@warning_ignore("unused_signal")
signal all_menus_close()
@warning_ignore("unused_signal")
signal log_show(log_text: String)
@warning_ignore("unused_signal")
signal sfx(sfx_name: String)
@warning_ignore("unused_signal")
signal show_quantity_menu(vis: bool, n: int, buffer: Array)
@warning_ignore("unused_signal")
signal result_quantity_menu(n: int, buffer: Array)
@warning_ignore("unused_signal")
signal show_quest()
@warning_ignore("unused_signal")
signal quest_finished()
@warning_ignore("unused_signal")
signal camera_move(position)
@warning_ignore("unused_signal")
signal alert_show(alert_name: String, res_data: Resource)

## --- ЖИЗНЕННЫЙ ЦИКЛ СЕССИИ ---
@warning_ignore("unused_signal")
signal loading()          # начало загрузки уровня/сессии
@warning_ignore("unused_signal")
signal save()             # запрос на сохранение
@warning_ignore("unused_signal")
signal cleanup_game()     # запрос на очистку игрового мира
@warning_ignore("unused_signal")
signal delete_place(place_data: PlaceData)

@warning_ignore("unused_signal")
signal change(place_data: PlaceData)


@warning_ignore("unused_signal")
signal time_tick(n: int)
@warning_ignore("unused_signal")
signal time_ticked(n: int)


## --- ГЕНЕРАЦИЯ КОНТЕНТА ---
@warning_ignore("unused_signal")
signal enemies_generated(enemies: Array[EntityData])


@warning_ignore("unused_signal")
signal create_place()
## --- СОСТОЯНИЕ ИГРОКА ---
@warning_ignore("unused_signal")
signal player_changed(player_data: EntityData)

@warning_ignore("unused_signal")
signal player_equip_change(equip_data: ItemStack)

@warning_ignore("unused_signal")
signal check_equip(equip_data: ItemStack)

@warning_ignore("unused_signal")
signal equip(equip_data: ItemStack)
@warning_ignore("unused_signal")
signal unequip(equip_data: ItemStack)


## --- ДЕЙСТВИЯ ИГРОКА ---

@warning_ignore("unused_signal")
signal player_teleport(direction: Vector2)

@warning_ignore("unused_signal")
signal show_player_stats(vis: bool)

@warning_ignore("unused_signal")
signal player_move_to(direction: Vector2)
@warning_ignore("unused_signal")
signal player_moved(pos: Vector2)

## --- ВЗАИМОДЕЙСТВИЕ С СУЩНОСТЯМИ ---
@warning_ignore("unused_signal")
signal card_selected(data: Resource)

## --- СМЕРТЬ И УДАЛЕНИЕ ---
@warning_ignore("unused_signal")
signal object_died(obj: Resource)  # обобщённый сигнал (можно уточнить тип позже)
