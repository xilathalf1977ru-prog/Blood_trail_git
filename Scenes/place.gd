extends Node2D

var card_data: Resource:
	get:
		return $CardPlace.card_data
func setup(data: Resource, type: String):
	$CardPlace.setup(data, type)
func _on_button_select_pressed():
	$CardPlace._on_button_select_pressed()
