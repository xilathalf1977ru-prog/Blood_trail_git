extends Node

const L: Dictionary[String, Dictionary] = {
	"en":{
			"armor":				"armor",
			"damage":			"damage",
			"hp":				"hp",
			"Helm iron":			"Helm iron",
			"Sword iron":		"Sword iron",
			"Sword wolfkiller":	"Sword wolfkiller",
			"Goblin head":"Goblin head",
			"Goblin fat head":"Goblin fat head",
			"Wolf head":"Wolf head",
			"Elixir HP 50":"Elixir HP 50",
			"My home":"My home",
			"Inventory player":"Inventory player",
			"Inventory":"Inventory",
			"Trade":"Trade",
			
			"quest1": 	
				'Hello "hero", your goal is to find the sword in the stone.



				Without him, you"re weak, and you"ll be defeated by just a wolf...


				The sword is on the other side of the world.
				You can go through both the west and the east.
				I hope you know where west and east are???
				West is to the left, east is to the right!!!!
				',
			"quest1_end": 
				'Ha! You completed the task...
				it"s amazing, we thought there was nothing you couldn"t handle.
				Many could not fulfill it, and simply passed away.
				You can be proud of yourself, 
				and you can try to chop a wolf into mincemeat with this glorious sword, 
				if you are completely healthy.
				',
			"alert_portal":
				'The portal is a risk!
				He"ll teleport you.
				But a dangerous enemy can attack.
								
				Would you risk it?
				',
			"alert_sleep":
				'Sleeping on the trail is a risk! You will heal,
				but a dangerous enemy may attack.

				Would you risk it?
				',
		},
	"ru":{
			"armor":				"броня",
			"damage":			"урон",
			"hp":				"здоровье",
			"Helm iron":			"Железный шлем",
			"Sword iron":		"Железный меч",
			"Sword wolfkiller":	"Меч волкодав",
			"Goblin head":"Голова гоблина",
			"Goblin fat head":"Голова жирного гоблина",
			"Wolf head":"Голова волка",
			"Elixir HP 50":"Эликсир здоровья 50",
			"My home":"Мой дом",
			"Inventory player":"Инвентарь игрока",
			"Inventory":"Инвентарь",
			"Trade":"Магазин",
			
			"quest1": 	
				'Здравствуй "герой", твоя цель найти меч в камне.



				Без него ты слаб, и тебя победит просто волк...


				Меч находится на другом конце мира.
				Можешь идти и через запад и через восток.
				Надеюсь ты знаешь, где запад и восток???
				Запад это налево, восток это направо!!!!
				',
			"quest1_end":
				'Ха! Ты выполнил задание...
				Удивительно, мы думали что тебе не за что не справиться.
				Многие не смогли его выполнить, и просто ушли в мир иной.
				Ты можешь собой гордиться, 
				и можешь попробовать порубить волка в фарш, 
				этим славным мечом, если ты полностью здоров.
				',
			"alert_portal":
				'Портал это риск!
				Он телепортирует тебя.
				Но опасный враг может напасть.
				
				Рискнёшь?
				',
			"alert_sleep":
				'Спать на тропе это риск! Ты исцелишься, 
				но опасный враг может напасть.
			
				Рискнёшь?
				',
		},
}
var lang: String = "en"
func lc(text: String) -> String:
	return L[lang][text]


const A: Dictionary[String, Dictionary] = {
	"en":{
		"voice":preload("res://Voice/en/voice_en.ogg"),
		"voice2":preload("res://Voice/en/voice2_en.ogg"),
		"teleport_rng":preload("res://Voice/en/alert_portal_en.ogg"),
		"sleep":preload("res://Voice/en/alert_sleep_en.ogg"),
		},
	"ru":{
		"voice":preload("res://Voice/ru/voice_ru.ogg"),
		"voice2":preload("res://Voice/ru/voice2_ru.ogg"),
		"teleport_rng":preload("res://Voice/ru/alert_portal_ru.ogg"),
		"sleep":preload("res://Voice/ru/alert_sleep_ru.ogg"),
		},
	}
func alc(text: String) -> AudioStream:
	return A[lang][text]
