extends Node

const L: Dictionary[String, Dictionary] = {
	"en":{
			"armor":		"armor",
			"damage":	"damage",
			"hp":		"hp",
		},
	"ru":{
			"armor":		"броня",
			"damage":	"урон",
			"hp":		"здоровье",
		},
}
var lang: String = "ru"
func lc(text: String) -> String:
	return L[lang][text]
