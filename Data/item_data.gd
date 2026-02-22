extends Resource
class_name ItemData

@export var name: String
@export var type: String
enum EditorType {NONE, USE, EQUIP}
@export var editor_main_type: EditorType = EditorType.NONE
var main_type: String:
	get:
		return EditorType.find_key(editor_main_type)

enum EditorEquip {WEAPON, HAT, TORSO, PANTS}
@export var editor_equip_type: EditorEquip = EditorEquip.WEAPON
var equip_type: String:
	get:
		return EditorEquip.find_key(editor_equip_type)

@export var equip_bonus: Dictionary[String, int]
var equiped: bool = false

@export var icon: Texture2D
@export var cost: int
@export var actions: Array[ActionData]

@export var transforms_to: ItemStack
