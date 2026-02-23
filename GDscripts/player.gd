extends Node2D

const DATA_PATH: String = "res://Data/Entities/"
var last_pos: Vector2 = Vector2(0, 0)
var timer_running: bool = false
@onready var data: EntityData = load(DATA_PATH + name + ".tres")
func _ready():
	GameManager.register_player(self)
	EventBus.player_move.connect(_on_player_move)
	EventBus.player_move_to.connect(_on_player_move_to)
	EventBus.player_changed.connect(_on_player_changed)
	EventBus.player_equip_change.connect(change_equip)
	$CardPlayer.setup(data, GC.PLAYER)
	EventBus.player_changed.emit(data)
	data.position = position
func _on_player_changed(player_data):
	data = player_data.duplicate()
	$CardPlayer.setup(data, GC.PLAYER)
func _on_player_move(pos: Vector2):
	if !timer_running:
		last_pos = pos
		timer_running = true
		await get_tree().create_timer(0.05).timeout
		move_check(pos, true)
		last_pos = Vector2(0, 0)
		timer_running = false
	else:
		last_pos += pos
func _on_player_move_to(pos: Vector2):move_check(pos, false)
func move_check(pos: Vector2, move: bool):
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
		if move and int(data.position.y + last_pos.y * GC.CELL) in GC.CELL_Y:
			data.position += last_pos * GC.CELL
		else:
			data.position.x += GC.CELL * direction
			var direction_y: int = int(pos.y)
			data.position.y = GC.CELL_Y[direction_y+1]
	position = data.position
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
