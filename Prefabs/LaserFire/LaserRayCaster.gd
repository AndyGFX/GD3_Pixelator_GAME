tool
extends Node2D



var hit = Vector2()
var dir = Vector2(0,1)
var target = Vector2()
export (float,0,360) var angle = 45.0
export var length = 32.0
var laser_color = Color(1.0, .329, .298)
var hit_color = Color(0.0, 1.0, 0.0)
var pos = Vector2(0,0)

func _ready():
	pass

func CastDirection():
	var space_state = get_world_2d().direct_space_state 	
	var result = space_state.intersect_ray(pos,self.target, [self]) 
	update()
	pass
	
func _draw():
	draw_circle(pos, 4, laser_color)
	draw_circle(target, 4, hit_color)
	draw_line(pos, target, laser_color) 
	pass
	
func _process(delta):
	if Engine.is_editor_hint():
        update()
	dir = Vector2(cos(angle* 0.01745329252), sin(angle* 0.01745329252)).normalized()	
	#pos = self.position #self.get_global_position()
	target = (dir*length)		
	CastDirection()
	pass