extends Node2D

var d = {
	0:null,
	2:null,
	3:null,
}

var d2 = {
	0:null,
	2:null,
	3:null,
	4:null,
}

func _ready() -> void:
	d.merge(d2)
	print(d.keys())
	print(d.keys().size())
