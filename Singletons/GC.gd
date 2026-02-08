extends Node

const CELL :int = 256

## --- ТИПЫ КАРТ ---
const PLAYER 	:String = "player"
const ENEMY 	:String = "enemy"
const PLACE 	:String = "place"
const FAR_PLACE :String = "far_place"
const ACTION 	:String = "action"
const ITEMSTACK :String = "itemstack"
#enum contexts {
	#PLAYER,
	#ENEMY,
	#PLACE,
	#FAR_PLACE,
	#ACTION,
	#ITEMSTACK,
#}

## --- ТИПЫ ДЕЙСТВИЙ ---
class Act:
	const HEAL		:String = "heal"
	const INV		:String = "inv"
	const MY_INV		:String = "my_inv"
	const TRADE		:String = "trade"
