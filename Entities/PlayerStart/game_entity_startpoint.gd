extends Area2D

var item_id = 0
var item_type = "start_point"

#------------------------------------------------
# Hide icon on start
#------------------------------------------------
func _ready():
	$Sprite.visible = !$Sprite.visible

#------------------------------------------------
# Enter to zone
#------------------------------------------------
func EnterToStartPoint():	
	GameData.Load()
	# additional code here
	pass

#------------------------------------------------
# Exit from zone
#------------------------------------------------
func ExitFromStartPoint():
	# additional code here
	pass
	
#------------------------------------------------
# Exit from zone
#------------------------------------------------
func Respawn(player):
	# additional code here
	player.set_global_position(self.get_global_position())
	pass	
	