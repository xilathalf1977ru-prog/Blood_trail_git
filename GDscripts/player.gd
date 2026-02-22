extends Node2D

const DATA_PATH: String = "res://Data/Entities/"

@onready var data: EntityData = load(DATA_PATH + name + ".tres")
func _ready():
	GameManager.register_player(self)
	EventBus.player_move.connect(_on_player_move)
	EventBus.player_changed.connect(_on_player_changed)
	EventBus.player_equip_change.connect(change_equip)
	$CardPlayer.setup(data, GC.PLAYER)
	EventBus.player_changed.emit(data)
	data.position = position
	#call_deferred("test")
#func test():
	#EventBus.player_move.emit(Vector2(32, 0))
func _on_player_changed(player_data):
	data = player_data.duplicate()
	$CardPlayer.setup(data, GC.PLAYER)
func _on_player_move(direction: Vector2):
	#print(direction.y)
	#var move_direction = int(direction.x)
	#print(move_direction)
	_move(direction)

func _move(pos: Vector2):
	var direction = int(pos.x)
	if (data.steps + direction) > GC.END_WORLD:
		var direction_post = direction - (GC.END_WORLD - data.steps)
		data.steps = -(GC.END_WORLD + 1) + direction_post
		data.position.x = data.steps * GC.CELL
	elif (data.steps + direction) < -GC.END_WORLD:
		var direction_post = direction - (-GC.END_WORLD - data.steps)
		data.steps = (GC.END_WORLD + 1) + direction_post
		data.position.x = data.steps * GC.CELL
	else:
		data.steps += direction
		data.position.x += GC.CELL * direction
		
	var direction_y: int = int(pos.y)
	#print(direction_y)
	#if direction_y == 1:
		#data.position.y = GC.CELL_Y[2]#GC.CELL * direction_y
	#elif direction_y == -1:
		#data.position.y = GC.CELL_Y[0]#GC.CELL * direction_y
	#elif :
	#	data.position.y = GC.CELL_Y[0]
	#print(direction_y+1)
	
	data.position.y = GC.CELL_Y[direction_y+1]
	
	
	position.x = data.position.x
	position.y = data.position.y
	EventBus.player_changed.emit(data)
	EventBus.player_moved.emit(data.position)
	$CardPlayer.setup(data, GC.PLAYER)
func load_data(player_data: EntityData):
	data = player_data
	position.x = data.position.x
	EventBus.player_changed.emit(data)
	$CardPlayer.setup(data, GC.PLAYER)
func change_equip(equip_data: ItemStack) -> void:
	if equip_data.equip_type in data.equip_slots:
		data.equip_slots.erase(equip_data.equip_type)
		change_stats(equip_data.equip_bonus, -1)
	else:
		data.equip_slots.append(equip_data.equip_type)
		change_stats(equip_data.equip_bonus, 1)
func change_stats(stat_values, direction):
	for i in stat_values.keys():
		match i:
			"attack": data.attack += (stat_values[i]) * direction
			"shield": data.shield += (stat_values[i]) * direction
	$CardPlayer.setup(data, GC.PLAYER)
