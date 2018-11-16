extends Sprite

export var fade_time = 1.0
export var fade_alpha_speed = 1
var alpha = 1.0

#func _ready():
#	var rnd_angle = rand_range(0,360)
#	self.set_rotation_degrees(rnd_angle)
#	Utils.CreateTimer(fade_time,self,"timeout",true) 
#	pass
#
#func _process(delta):
#	pass
#
#
#func timeout():
#	queue_free()
#	pass


func _ready():
	var rnd_angle = rand_range(0,360)
	self.set_rotation_degrees(rnd_angle)
	pass

func _process(delta):
	alpha = alpha - self.fade_alpha_speed*delta
	var color = self.self_modulate
	color.a = alpha
	self.self_modulate = color
	if alpha<=0: queue_free()
	pass
