extends ColorRect

const SLOT: Object = preload("res://Inv/inv_slot.tscn")
@export var path: VBoxContainer
var inv_data: Dictionary[String, ItemStack] = {}
var data: Resource
signal transfer
func setup() -> void: 
	for i in inv_data.keys(): add_slot(i)
func add_item(item_stack: ItemStack, n: int):
	#print_debug(n)
	data.add_item(item_stack, n)
	var key: String = item_stack.name
	if inv_data.has(key) and path.has_node(key):
		path.get_node(key).setup_vis(data.player, inv_data[key])
	else: add_slot(key)
func add_slot(key: String):
	var slot: Panel = SLOT.instantiate()
	slot.item_del.connect(reduce_item)
	slot.item_transfer.connect(transfer_item)
	slot.setup_vis(data.player, inv_data[key])
	path.add_child(slot)
func reduce_item(item_stack: ItemStack, n: int):
	#print_debug(n)
	data.reduce_item(item_stack, n)
	var key: String = item_stack.name
	if inv_data.has(key):
		path.get_node(key).setup_vis(data.player, inv_data[key])
	else:
		path.get_node(key).queue_free()
func clear(): for slot in path.get_children(): slot.queue_free()
func transfer_item(item: ItemStack, n: int): 
	transfer.emit(item, n)
