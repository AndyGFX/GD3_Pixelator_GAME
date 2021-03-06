extends Area2D


var item_type = "health"
export var item_amount = 100
export var item_id = 0
export var item_limit = 100

func _get_item_rect():
	return self.get_node("Sprite").get_item_rect()

func _ready():
	self.add_to_group("ITEM")
	pass

# ---------------------------------------------------------
# pickup item method which is called from area detector assigned on player
# ---------------------------------------------------------
func PickupHealth():
	
	if !GameData: return
	
	if GameData.Get(item_type)>=item_limit: return
	
	GameData.AddWithLimitCheck(item_type,item_amount,item_limit);
	Utils.Instantiate(Globals.pickup_anim,get_global_position())
	Globals.player_sfx.Play("Pickup")
	queue_free()
