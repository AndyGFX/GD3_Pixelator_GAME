extends Camera2D

var player = null
func _ready():
	self.player = Utils.FindNode("Player")
	pass

func _process(delta):
	position = self.player.position
	pass
