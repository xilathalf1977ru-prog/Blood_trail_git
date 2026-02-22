extends VBoxContainer

const CARD_SCENE: Object = preload("res://UI/card.tscn")

func setup_card_common(card: TextureRect, res_data) -> void:
	card.setup_vis(res_data)
	add_child(card)
func add_item_quantity(item_stack: ItemStack, n: int):
	var local_item_stack: Resource = get_node(item_stack.name).card_data
	local_item_stack.quantity += n
	get_node(local_item_stack.name).setup_vis(local_item_stack)
