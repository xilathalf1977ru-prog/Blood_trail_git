extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var a = test()
	print(a)
func test():
	var sr = 65
	var el = 2
	return [sr, el]
