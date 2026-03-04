class_name EquipManagerComponent
extends Node

var data: EntityData:
	get: return get_parent().data
func _ready() -> void:
	EventBus.player_equip_change.connect(change_equip)
	EventBus.check_equip.connect(on_check_equip)
func change_equip(equip_data: ItemStack) -> void:
	
	if equip_data.equip_type == "WEAPON":
		EventBus.sfx.emit("sword")
	else:
		EventBus.sfx.emit("armor")
	
	if !equip_data.equip_type in data.equip_slots.keys():
		equip(equip_data)
	elif data.equip_slots[equip_data.equip_type] != equip_data:
		unequip(data.equip_slots[equip_data.equip_type])
		equip(equip_data)
	else:
		unequip(equip_data)
func on_check_equip(equip_data: ItemStack) -> void:
	if equip_data.equip_type in data.equip_slots.keys():
		unequip(equip_data)
func equip(equip_data: ItemStack) -> void:
	data.equip_slots[equip_data.equip_type] = equip_data
	equip_data.equiped = true
	change_stats(equip_data.equip_bonus, 1)
	EventBus.equip.emit(equip_data)
func unequip(equip_data: ItemStack) -> void:
	equip_data.equiped = false
	change_stats(equip_data.equip_bonus, -1)
	data.equip_slots.erase(equip_data.equip_type)
	EventBus.unequip.emit(equip_data)
func change_stats(stat_values, direction):
	for i in stat_values.keys():
		match i:
			"атака": data.attack += (stat_values[i]) * direction
			"броня": data.shield += (stat_values[i]) * direction
	get_parent().get_node("CardPlayer").setup(data, GC.PLAYER)
	EventBus.player_changed.emit(data)
