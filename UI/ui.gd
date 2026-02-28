extends CanvasLayer

var place_card: TextureRect#Sprite2D
var cards: Array[TextureRect]
func _ready() -> void:
	EventBus.death_screen_changed.connect(show_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	place_card = $PlaceChoice/CardPlace
	cards = [
		$EnemyChoice/CardEnemy,
		$EnemyChoice/CardPlayer,
	]
func show_death_screen(vis :bool):
	$DeathScreen.visible = vis
func show_main_menu(vis :bool):$MainMenu.visible = vis


func _on_button_close_pressed() -> void:
	$History.visible = false
