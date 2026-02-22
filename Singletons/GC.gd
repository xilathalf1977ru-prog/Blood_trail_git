extends Node

const CELL: int = 192#256
const CELL_Y: Array = [353, 545, 737]
const END_WORLD: int = 4

## --- ТИПЫ КАРТ ---
const PLAYER: String = "player"
const ENEMY: String = "enemy"
const PLACE: String = "place"
const FAR_PLACE: String = "far_place"
const ACTION: String = "action"
const ITEMSTACK: String = "itemstack"

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
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
