extends Area2D

export var source_name = "<undefiend>"
export var target_name = "<undefiend>"
export var on_button = "key_use"
export var need_key_item = false
export var key_item_name = "<undefiend>"
export var teleport_type = 0

var eventOwner = null
var item_type = "teleport"
var _enabled_btn_check = false
#------------------------------------------------
# 
#------------------------------------------------
func _ready():
	pass
	
#------------------------------------------------
# teleport to target area when key_use is pressed on player
#------------------------------------------------
func Teleport(player):
	_enabled_btn_check = true
	#if need_key_item and GameData.HasItem(need_key,true): set_process(true)
	eventOwner = player
	pass

#------------------------------------------------
# reset prepared teleportation
#------------------------------------------------
func ResetTeleport():
	print("btn stop")
	_enabled_btn_check = false

func _process(delta):
	
	if Input.is_action_pressed(on_button) and _enabled_btn_check:
		_enabled_btn_check = false
		var target_node = Utils.FindNode(target_name)
		var target_pos = target_node.get_node("SpawnPosition")
		var pos = target_pos.get_global_position()
		eventOwner.set_position(pos)
	pass
