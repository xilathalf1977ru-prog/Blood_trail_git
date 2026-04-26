extends Control

const SELECT: Dictionary[String, int] = {
	GC.PLACE:		0,
	GC.Act.MY_INV:	0,
	GC.Act.TRADE:	0,
	GC.Act.INV:		1,
}
const QUANTITY_MENU_THRESHOLD: int = 3
var big_cards: Array[ColorRect]
func _ready() -> void:
	EventBus.menu.connect(show_menu)
	EventBus.check_all_menus_closed.connect(on_check_all_menus_closed)
	EventBus.all_menus_close.connect(close_all_menus)
	big_cards = [$BigCard0, $BigCard1, $BigCard2]
func show_menu(data: Resource, context: String) -> void:
	#visible = true
	var n: int = SELECT[context]
	if n == 0:
		for i in big_cards.size():
			big_cards[i].visible = false
			big_cards[i].get_node("Name").text = ""
			big_cards[i].clear_cards()
	if !(context in [GC.Act.INV, GC.Act.TRADE]):
		visible = true
		big_cards[n].visible = true
		big_cards[n].setup(data, context)
	else:
		_on_button_exit_pressed()
		
func on_check_all_menus_closed() -> void:
	if !big_cards[0].visible and !big_cards[1].visible and !big_cards[2].visible:
		visible = false
		
func close_all_menus() -> void:
	for i in big_cards.size():
		big_cards[i]._on_button_x_pressed()
func _on_button_exit_pressed() -> void:
	close_all_menus()
