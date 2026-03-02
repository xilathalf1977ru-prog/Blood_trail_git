extends VBoxContainer

const CARD_SCENE: Object = preload("res://UI/card.tscn")

func setup_card_common(card: TextureRect, res_data, name_owner) -> void:
	card.setup_vis(res_data, name_owner)
	add_child(card)
func add_item_quantity(item_stack: ItemStack, n: int, name_owner):
	var local_item_stack: Resource = get_node(item_stack.name).card_data
	local_item_stack.quantity += n
	get_node(local_item_stack.name).setup_vis(local_item_stack, name_owner)
