extends Node

var enemy_templates: Array[Resource] = []
var total_chance: float

func _ready():
	var enemies: Array[Resource] = DataLoader.load_res("res://Data/Entities/Enemies/")
	for i in enemies:
		i.on_resource_init()
		total_chance += i.spawn_chance
	enemy_templates = enemies
func generate_enemies(count: int) -> Array[EntityData]:
	var enemies: Array[EntityData] = []
	for i in count:
		var enemy: Resource = _create_random_enemy()
		enemy.direction = _get_direction_for_position(i, count)
		enemies.append(enemy)
	EventBus.enemies_generated.emit(enemies)
	return enemies
func _create_random_enemy():
	var r: float = randf() * total_chance
	var sum: float = 0.0
	for i in enemy_templates:
		sum += i.spawn_chance
		if r < sum: return i.duplicate()
func _get_direction_for_position(index: int, total_count: int) -> Vector2:
	# Простая логика: первые половина - слева, вторая - справа
	var vector_enemy: Vector2 = Vector2(0, 0)
	var y: int = index % 3
	if y == 0:
		vector_enemy += Vector2.UP
	elif y == 2:
		vector_enemy += Vector2.DOWN
	var half: float = total_count / 2.0
	if index < half:
		vector_enemy += Vector2.LEFT
	else:
		vector_enemy += Vector2.RIGHT
	return vector_enemy
