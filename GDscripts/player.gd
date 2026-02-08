extends Node2D

const DATA_PATH: String = "res://Data/Entities/"
@onready var data: EntityData = load(DATA_PATH + name + ".tres")
func _ready():
	GameManager.register_player(self)
	EventBus.player_move.connect(_on_player_move)
	EventBus.player_changed.connect(_on_player_changed)
	EventBus.player_changed.emit(data)
	#EventBus.player_moved.emit(data.steps)
	$Card.setup(data, GC.PLAYER)
	#EventBus.player_moved.emit(data.steps)
func _on_player_move(direction: Vector2):
	var move_direction = int(direction.x)
	_move(move_direction)
func _on_player_changed(player_data):
	data = player_data.duplicate()
	$Card.setup(data, GC.PLAYER)
func _move(direction: int):
	var move_distance = GC.CELL * direction
	data.steps += direction
	data.position += move_distance
	position.x += move_distance
	EventBus.player_changed.emit(data)
	EventBus.player_moved.emit(data.steps)
	$Card.setup(data, GC.PLAYER)
func take_damage(damage: int):
	data.current_hp -= damage
	EventBus.player_changed.emit(data)  # Обновляем состояние после урона
func add_food(amount: int):data.food += amount
func load_data(player_data: EntityData):
	data = player_data
	position.x = data.position
	EventBus.player_changed.emit(data)
	$Card.setup(data, GC.PLAYER)
