tool
extends KinematicBody2D



var hit = Vector2()
var dir = Vector2(0,1)
var target = Vector2()
export (float,0,360) var angle = 0
export (float,0,128)var length = 32.0

var laser_color = Color(1.0, .329, .298)
var hit_color = Color(0.0, 1.0, 0.0)
var pos = Vector2(0,0)
var ray_result

func _ready():
	
	pass

func CastDirection():
	var space_state = get_world_2d().direct_space_state
	
	var rad = deg2rad(angle)
	dir = Vector2(cos(rad), sin(rad)).normalized()
	target = (dir*length)
	
	ray_result = space_state.intersect_ray(self.position,self.position+self.target, [self], collision_mask) 
	if ray_result:
#		print(ray_result.collider.get_name())
#		print(ray_result.position)
		print(angle)
		pass
		
	
	
	if ray_result:
		target = ray_result.position
		
	update()
	pass
	
func _draw():
	if ray_result:
		draw_circle(pos, 4, laser_color)
		draw_circle(target-self.position, 4, hit_color)
		draw_line(pos, target-self.position, laser_color) 
	pass
	
func _process(delta):
	if Engine.is_editor_hint():
        update()
	angle = angle + 5
	
	if angle>360: angle = 0.0
	CastDirection()
	pass