extends Resource
class_name SaveData

@export var player_data: EntityData
@export var timestamp: String
@export var enemies: Array[EntityData]
@export var invs: Dictionary[String, Dictionary]
@export var invs_money: Dictionary[String, int]
func _init():
	timestamp = Time.get_datetime_string_from_system()
