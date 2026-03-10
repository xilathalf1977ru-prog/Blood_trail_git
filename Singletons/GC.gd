extends Node

var control_free: bool = true

const CELL: int = 192
const CELL_Y: Array = [353, 545, 737]
#const CELL_PLACE: int = 737
var cell_place_y: int:
	get:
		return CELL_Y[2]
const END_WORLD: int = 9

var anim_speed: float = 0.2

## --- ТИПЫ КАРТ ---
const PLAYER: String = "player"
const ENEMY: String = "enemy"
const PLACE: String = "place"
const FAR_PLACE: String = "far_place"
const ACTION: String = "action"
const ITEMSTACK: String = "itemstack"


## --- ТИПЫ ЛОКАЦИЙ ---
const LOOT: String = "loot"


## --- ТИПЫ ДЕЙСТВИЙ ---
class Act:
	const HEAL: String = "heal"
	const INV: String = "inv"
	const MY_INV: String = "my_inv"
	const TRADE: String = "trade"
	const RANDOM_ATTACK: String = "random_attack"
	const TELEPORT_RNG: String = "teleport_rng"
	const SLEEP: String = "sleep"
	const EQUIP: String = "equip"
	
	const UNEQUIP: String = "unequip"


const SFX: Dictionary[String, AudioStream] = {
	"attack":preload("res://SFX/SwordParry1.wav"),
	"dead":preload("res://SFX/ManDead.mp3"),
	"drink":preload("res://SFX/Drink.mp3"),
	"loot":preload("res://SFX/loot.mp3"),
	"drop":preload("res://SFX/Drop.mp3"),
	"armor":preload("res://SFX/armor.wav"),
	"sword":preload("res://SFX/sword.wav"),
	"walk":preload("res://SFX/walk.mp3"),
	"portal":preload("res://SFX/portal.mp3"),
}


var rng: RandomNumberGenerator = RandomNumberGenerator.new()
