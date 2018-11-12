extends Path2D

onready var follow = $PathFollow2D

export var speed = 2
var tween
var _start = 0
var _end = 0.9999

func _ready():
	self.tween = Tween.new()
	self.add_child(tween)
	self.tween.interpolate_property(self.follow,"unit_offset",_start,_end,speed,self.tween.TRANS_LINEAR,self.tween.EASE_IN_OUT)	
	self.tween.start()
	self.tween.connect("tween_completed",self,"SwapDirection")
	pass

func SwapDirection(object, path):
	var tmp = _start
	_start = _end
	_end = tmp
	self.follow.set_unit_offset(_start)
	self.tween.interpolate_property(self.follow,"unit_offset",_start,_end,speed,self.tween.TRANS_LINEAR,self.tween.EASE_IN_OUT)	
	self.tween.start()
	pass