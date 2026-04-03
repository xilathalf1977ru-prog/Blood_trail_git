extends Node

var lang: String = "ru"
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
			
			"quest_s0":"Take the sword in stone in the East",
			"quest_s1":"Kill the wolf",
			"quest_s2":"Drink 3 max hp boost potions, they are in the store",
			"quest_s3":"Take the armor in the cave in the west and put on the armor",
			"quest_s4":"Put on the armor",
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
			"quest4":
				'That"s great, now this armor is yours.
				Put it on, and
				the next interesting task will be waiting for you!
				',
			"bad_end":
				'You put on the armor, and yes, it"s really beautiful.
				When suddenly you feel like you"re losing control…
				Your head is spinning, your legs are not listening to you!!!
				And a terrible pain pierces every nerve. 
				The last thing you hear
				before your body becomes a trap for your consciousness
				is the terrible laughter of the witch.
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
			"alert_cave":
				'You can see the entrance to the cave.
				There you see a mad and angry woman.
				But what shocks you is something else...

				She looks like you from the future...
				Are you sure you want to go there?
				And fight her?
				',
			"alert_tower":
				'Stop! There"s nothing interesting there...
				You don"t need to go there, I assure you...
				Come on, go away.
				(Leave? Yes or no?)
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
			
			"quest_s0":"Взять меч в камне на востоке",
			"quest_s1":"Убей волка",
			"quest_s2":"Выпей 3 зелья повышения макс хп, они в магазине",
			"quest_s3":"Взять доспех в пещере на западе и надеть доспех",
			"quest_s4":"Одеть доспех",
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
			"quest4":
				'Вот отлично, теперь этот доспех твой.
				Одень его, и тебя будет ждать...
				Следующее интересное задание!
				',
			"bad_end":
				'Вы одеваете доспех, и да, он действительно прекрасен.
				Как вдруг вы чувствуете, что теряете контроль…
				Ваша голова идёт кругом, ваши ноги вас не слушаются!!!
				И ужасная боль пронзает каждый нерв. 
				Последнее, что вы слышите, 
				прежде чем ваше тело станет ловушкой для вашего сознания, 
				это ужасный смех ведьмы.
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
			"alert_cave":
				'Вы видите вход в пещеру.
				Там вы видите безумную и злую женщину.
				Но шокирует вас другое...

				Она похожа на вас из будущего…
				Вы уверены, что хотите идти туда?
				И сражаться с ней?
				',
			"alert_tower":
				'Стой! Там нет ничего интересного…
				Тебе туда не надо, уверяю тебя…
				Давай уходи.
				(Уйти? Да или нет?)
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
