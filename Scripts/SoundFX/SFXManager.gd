extends Node

var SFXList = {}

func _ready():
	var sfx_count = self.get_child_count()
	for idx in range(sfx_count):		
		self.SFXList[self.get_child(idx).name] = self.get_child(idx)		
	pass

func Play(sfx_name):

	if self.SFXList.has(sfx_name):
		self.SFXList[sfx_name].play()
	else:
		print("ERROR: missing AudioStreamPlayer2D with ''"+sfx_name+"' name")
	pass