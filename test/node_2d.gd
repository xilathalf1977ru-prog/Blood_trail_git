extends Node2D
#222
var test4 = ["a", "b"]
var test5 = {"a":0, "b":1}

func _ready() -> void:
	test4.remove_at(0)
	print(test4)
