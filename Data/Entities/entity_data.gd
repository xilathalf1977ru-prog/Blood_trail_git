extends Resource

class_name EntityData  # ⭐ВАЖНО: даём имя классу!

@export var name: String
@export var player: bool
@export var max_hp: int
@export var current_hp: int
@export var food: int
@export var position: int
@export var steps: int
@export var attack_speed: int
@export var damage: int
@export var direction: Vector2
#@export var money: int
@export var actions: Array[ActionData]
@export var inv: ActionData
#func to_dict() -> Dictionary:
	#return {
		#"name": name,
		#"player": player,
		#"max_hp": max_hp,
		#"current_hp": current_hp, 
		#"food": food,
		#"position": position,
		#"steps": steps,
		#"attack_speed": attack_speed,
		#"damage": damage,
		#"direction": direction,
	#}
