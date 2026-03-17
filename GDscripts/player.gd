extends Node2D

const DATA_PATH: String = "res://Data/Entities/"
var last_pos: Vector2 = Vector2(0, 0)
var timer_running: bool = false
@onready var data: EntityData = load(DATA_PATH + name + ".tres")
func _ready():
	data.current_hp = data.max_hp
	GameManager.register_player(self)
	EventBus.player_move.connect(_on_player_move)
	EventBus.player_teleport.connect(_on_player_teleport)
	EventBus.player_move_to.connect(_on_player_move_to)
	EventBus.show_player_stats.connect(_on_show_player_stats)
	$CardPlayer.setup(data, GC.PLAYER)
	EventBus.player_changed.emit(data)
	data.position = position
func _on_player_move(pos: Vector2):
	if !timer_running:
		last_pos = pos
		timer_running = true
		await get_tree().create_timer(0.05).timeout
		move_check(last_pos, true)
		last_pos = Vector2(0, 0)
		timer_running = false
	else:
		last_pos += pos
func _on_player_move_to(pos: Vector2):
	move_check(pos, false)
func move_check(pos: Vector2, move: bool):
	var direction = int(pos.x)
	if move and int(data.position.y + last_pos.y * GC.CELL) in GC.CELL_Y:
		data.position += last_pos * GC.CELL
	else:
		data.position.x += direction * (GC.CELL)
		var direction_y: int = int(pos.y)
		data.position.y = GC.CELL_Y[direction_y+1]
	var tween = create_tween()
	tween.finished.connect(_on_tween_finished.bind(direction))
	GC.control_free = false
	EventBus.sfx.emit("walk")
	tween.tween_property(self, "position", data.position, GC.anim_speed)
func _on_tween_finished(direction):
	if (data.steps + direction) > GC.END_WORLD:
		over_limit(-1)
	elif (data.steps + direction) < -GC.END_WORLD:
		over_limit(1)
	else:
		data.steps += direction
	EventBus.player_changed.emit(data)
	EventBus.player_moved.emit(data.position)
	if direction != 0:
		GameManager.current_enemies = EnemyManager.generate_enemies(6)
		EventBus.time_tick.emit(1)
	$CardPlayer.setup(data, GC.PLAYER)
	EventBus.camera_move.emit(data.position.x)
	GC.control_free = true
func over_limit(limit: int):
	data.steps = GC.END_WORLD * limit
	data.position.x = data.steps * GC.CELL
	position = data.position
	EventBus.camera_move.emit(data.position.x - (-GC.CELL * limit), false)
func load_data(player_data: EntityData):
	data = player_data
	position.x = data.position.x
	EventBus.player_changed.emit(data)
	$CardPlayer.setup(data, GC.PLAYER)
func _on_show_player_stats(vis):
	if vis:$CardPlayer._on_button_select_mouse_entered()
	else:$CardPlayer._on_button_select_mouse_exited()
func _on_player_teleport(direction: int):
	GC.control_free = false
	await fade_out(self)
	var change_pos_x: int = direction * GC.CELL
	data.position.x += change_pos_x
	position = data.position
	_on_tween_finished(direction)
	fade_in(self)
func fade_out(node, duration: float = GC.anim_speed):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)
	tween.tween_callback(func(): node.visible = false)
	await tween.finished
func fade_in(node, duration: float = GC.anim_speed):
	node.visible = true
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)
	await tween.finished
