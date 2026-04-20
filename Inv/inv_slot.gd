extends Panel

var local_item_stack: ItemStack

signal item_stack_del

func setup_vis(player: bool, item_stack: ItemStack) -> void:
	if item_stack.quantity == 0:
		visible = false
		name = "null"
		return
	
	local_item_stack = item_stack
	$TextureRect.texture = item_stack.icon
	name = item_stack.name
	$Name.text = TR.lc(item_stack.name) + " X" + str(item_stack.quantity)
	if player:
		$ButtonExtra.set_extra_button(item_stack)
	visible = true


func _on_button_extra_pressed() -> void:
	
	if local_item_stack.main_type == "EQUIP":
		ActionManager.handle_action(local_item_stack, GC.Act.EQUIP)
		return
	elif local_item_stack.main_type == "HEAL":
		EventBus.sfx.emit("drink")
		ActionManager.handle_action(local_item_stack, GC.Act.HEAL, 1)
		#if local_item_stack.transforms_to:
			#add_item(local_item_stack.transforms_to, n)
	#elif local_item_stack.main_type == "BONUS":
		#EventBus.sfx.emit("drink")
		#ActionManager.handle_action(local_item_stack, GC.Act.BONUS)
		#if local_item_stack.transforms_to:
			#add_item(local_item_stack.transforms_to, n)
	#remove_item(local_item_stack, n)
	item_stack_del.emit(local_item_stack, 1)
	
	
