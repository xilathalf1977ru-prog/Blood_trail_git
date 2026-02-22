extends Node2D

#var context: String
#var card_data: Resource

func setup(data: Resource, type: String):
	#card_data = data
	#context = type
	data.position = position
	$CardEntity.setup(data, type)
