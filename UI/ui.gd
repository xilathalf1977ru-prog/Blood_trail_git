extends CanvasLayer

var place_card :Sprite2D
var cards :Array[Sprite2D]
func _ready() -> void:
	EventBus.enemies_generated.connect(show_cards)
	EventBus.death_screen_changed.connect(show_death_screen)
	EventBus.main_menu_changed.connect(show_main_menu)
	EventBus.player_at_place.connect(show_card_place)
	place_card = $PlaceChoice/CardPlace
	cards = [
		$EnemyChoice/CardLeft1,
		$EnemyChoice/CardLeft2,
		$EnemyChoice/CardLeft3,
		$EnemyChoice/CardRight1,
		$EnemyChoice/CardRight2,
		$EnemyChoice/CardRight3,
	]
func show_cards(enemies: Array[EntityData]) -> void:
	$EnemyChoice.visible = true
	for i in min(enemies.size(), cards.size()):
		var enemy_data = enemies[i]
		var card = cards[i]
		card.setup(enemy_data, GC.ENEMY)
func show_card_place(data: PlaceData, vis: bool) -> void:
	place_card.visible = vis
	place_card.setup(data, GC.PLACE)
func show_death_screen(vis :bool):
	$DeathScreen.visible = vis
func show_main_menu(vis :bool):$MainMenu.visible = vis
