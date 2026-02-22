extends Node

var enemy_templates: Array[Resource] = []

func _ready():
	enemy_templates = DataLoader.load_res("res://Data/Entities/Enemies/")
func generate_enemies(count: int) -> Array[EntityData]:
	var enemies: Array[EntityData] = []
	for i in count:
		var enemy = _create_random_enemy()
		enemy.direction = _get_direction_for_position(i, count)
		enemies.append(enemy)
	EventBus.enemies_generated.emit(enemies)
	return enemies
func _create_random_enemy():
	var template = enemy_templates[randi() % enemy_templates.size()]
	return template.duplicate()
func _get_direction_for_position(index: int, total_count: int) -> Vector2:
	# Простая логика: первые половина - слева, вторая - справа
	#print(index % 3)
	var vector_enemy = Vector2(0, 0)
	var y = index % 3
	if y == 0:
		vector_enemy += Vector2.UP
	elif y == 2:
		vector_enemy += Vector2.DOWN
	var half = total_count / 2.0
	if index < half:
		vector_enemy += Vector2.LEFT
		#return Vector2.LEFT
	else:
		vector_enemy += Vector2.RIGHT
	#print(vector_enemy)
	return vector_enemy
