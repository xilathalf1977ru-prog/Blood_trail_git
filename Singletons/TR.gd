extends Node

var lang: String = "en"
const L: Dictionary[String, Dictionary] = {
	"en":{
			"Player":			"Player",
			"armor":				"armor",
			"damage":			"damage",
			"hp":				"hp",
			"Inventory player":"Inventory player",
			"Inventory":"Inventory",
			
			##Существа
			"Goblin":"Goblin",
			"Goblin fat":"Goblin fat",
			"Wolf":"Wolf",
			"Guard":"Guard",
			"Bear":"Bear",
			"Elf zombie":"Elf zombie",
			"Witch":"Witch",
			
			##Вещи
			"Helm iron":			"Helm iron",
			"Strange armor":		"Strange armor",
			"Sword iron":		"Sword iron",
			"Sword wolfkiller":	"Sword wolfkiller",
			"Goblin head":"Goblin head",
			"Goblin fat head":"Goblin fat head",
			"Wolf head":"Wolf head",
			"Bear head":"Bear head",
			"Elixir HP 50":"Elixir HP 50",
			"Elixir MAX HP 10":"Elixir MAX HP 10",
			"Bottle empty":"Bottle empty",
			"Flask empty":"Flask empty",
			
			##Локации
			"My home":"My home",
			"Trade":"Trade",
			"Portal":"Portal",
			"Pocket":"Pocket",
			"Cave":"Cave",
			"Tower":"Tower",
			
			"Drink":"Drink",
			
			"Enemy killed:":"Enemy killed:",
			"You killed by:":"You killed by:",
			"Enemy attacked:":"Enemy attacked:",
			"Cured by:":"Cured by:",
			"You received item:":"You received item:",
			"Quest is completed":"Quest is completed",
			"Teleported to:":"Teleported to:",
			"How much?":"How much?",
			
			"quest0": 	
				'Hello, "hero". Your goal is to find the sword in the stone.



				Without him, you"re weak, and you"ll be defeated by just a wolf...


				The sword is in the east.
				I hope you know where west and east are???
				West is to the left, east is to the right!!!!
				',
			"quest1": 
				'Ha! You completed the task.…
				Now you have the wolfkiller sword.
				Show the wolf who is the crown of evolution here!!! 
				And who is the ultimate predator here!!!
				If you are completely healthy, then you can…
				',
			"quest2":
				'That"s great! You got the wolf"s head…
				The next target is the store.
				You need to sell the heads if you haven"t eaten them.
				And buy all three health enhancement potions there.
				And then drink them!
				',
			"quest3":
				'Is it delicious?
				If you are completely healthy…
				In the cave to the west, it"s on the left. You"ll find some cool armor!
				He is guarded by a mad warrior, but you are stronger than her!
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
			"alert_rob":
				'Robbery is a risk!
				Fight with the guards, you could die.
				But if you"re stronger, you"ll take it all.
								
				Would you risk it?
				',
		},
	"ru":{
			"Player":			"Игрок",
			"armor":				"броня",
			"damage":			"урон",
			"hp":				"здоровье",
			"Inventory player":"Инвентарь игрока",
			"Inventory":"Инвентарь",
			
			##Существа
			"Goblin":"Гоблин",
			"Goblin fat":"Жирный гоблин",
			"Wolf":"Волк",
			"Guard":"Страж",
			"Bear":"Медведь",
			"Elf zombie":"Эльф зомби",
			"Witch":"Ведьма",
			
			##Вещи
			"Helm iron":			"Железный шлем",
			"Strange armor":		"Странный доспех",
			"Sword iron":		"Железный меч",
			"Sword wolfkiller":	"Меч волкодав",
			"Goblin head":"Голова гоблина",
			"Goblin fat head":"Голова жирного гоблина",
			"Wolf head":"Голова волка",
			"Bear head":"Голова медведя",
			"Elixir HP 50":"Эликсир хп 50",
			"Elixir MAX HP 10":"Эликсир макс хп 10",
			"Bottle empty":"Пустая бутылка",
			"Flask empty":"Пустая колба",
			
			##Локации
			"My home":"Мой дом",
			"Trade":"Магазин",
			"Portal":"Портал",
			"Pocket":"Мешок",
			"Cave":"Пещера",
			"Tower":"Башня",
			
			"Drink":"Выпить",
			
			"Enemy killed:":"Враг убит:",
			"You killed by:":"Вас убил:",
			"Enemy attacked:":"Напал враг:",
			"Cured by:":"Вылечился на:",
			"You received item:":"Вы получили вещь:",
			"Quest is completed":"Задание выполнено",
			"Teleported to:":"Телепортировался на:",
			"How much?":"Сколько?",
			
			"quest0": 	
				'Здравствуй, «герой». Твоя цель — найти меч в камне.
				
				
				
				Без него ты слаб, и тебя победит просто волк…
				
				
				Меч находится на востоке.
				Надеюсь, ты знаешь, где запад и восток???
				Запад — это налево, восток — это направо!!!!
				',
			"quest1":
				'Ха! Ты выполнил задание…
				Теперь у тебя есть меч «волкодав».
				Покажи волку, кто тут венец эволюции!!! И кто тут высший хищник!!!
				Если ты полностью здоров, то ты сможешь…
				',
			"quest2":
				'Великолепно! Ты добыл голову волка…
				Следующая цель — это магазин.
				Тебе нужно продать головы, если ты их не съел.
				И купить там все три зелья увеличения здоровья.
				А потом их выпить!
				',
			"quest3":
				'Ну что, вкусно?
				Если ты полностью здоров…
				В пещере на западе, это налево. Ты найдёшь классный доспех!
				Его охраняет безумная воительница, но ты сильнее её!
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
			"alert_rob":
				'Грабёж это риск!
				Бой с охраной, ты можешь погибнуть.
				Но если ты сильнее, ты возьмёшь всё.
								
				Рискнёшь?
				',
		},
}

func lc(text: String) -> String: return L[lang][text]
const A: Dictionary[String, Dictionary] = {
	"en":{
		"quest0_voice":preload("res://Voice/en/voice_en.ogg"),
		"quest1_voice":preload("res://Voice/en/voice2_en.ogg"),
		"teleport_rng":preload("res://Voice/en/alert_portal_en.ogg"),
		"sleep":preload("res://Voice/en/alert_sleep_en.ogg"),
		"rob":preload("res://Voice/en/alert_rob_en.ogg"),
		},
	"ru":{
		"quest0_voice":preload("res://Voice/ru/voice_ru.ogg"),
		"quest1_voice":preload("res://Voice/ru/voice2_ru.ogg"),
		"teleport_rng":preload("res://Voice/ru/alert_portal_ru.ogg"),
		"sleep":preload("res://Voice/ru/alert_sleep_ru.ogg"),
		"rob":preload("res://Voice/ru/alert_rob_ru.ogg"),
		},
	}
func alc(text: String) -> AudioStream: return A[lang][text]
