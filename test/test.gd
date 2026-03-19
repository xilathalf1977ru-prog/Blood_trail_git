extends Node2D


func _ready() -> void:
	for i in 6:
		var a = get_random_enemy()
		print(a)


var enemies = {
	"Орк": 1.0,
	"Гоблин": 1.0,
	"Волк": 0.8,
	"Медведь": 0.2,
}

func get_random_enemy() -> String:
	var total = 0.0
	for chance in enemies.values():
		total += chance
	var r = randf() * total
	var sum = 0.0
	for enemy in enemies:
		sum += enemies[enemy]
		if r < sum:
			return enemy
	breakpoint
	return "ERROR"
