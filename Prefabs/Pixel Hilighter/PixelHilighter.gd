extends Sprite

export var fade_time = 1.0

func _ready():
	var rnd_angle = rand_range(0,360)
	self.set_rotation_degrees(rnd_angle)
	Utils.CreateTimer(fade_time,self,"timeout",true) 
	pass

func _process(delta):
	pass


func timeout():
	queue_free()
	pass