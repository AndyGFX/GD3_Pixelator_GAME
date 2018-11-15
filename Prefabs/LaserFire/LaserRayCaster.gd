#tool
extends KinematicBody2D



var hit = Vector2()
var dir = Vector2(0,1)
var target = Vector2()
var angle = 0
export (float,0,128)var length = 128.0
export var angle_step = 2
export var angle_offset = 0
export var debug = false;
var laser_color = Color(1.0, .329, .298)
var hit_color = Color(0.0, 1.0, 0.0)
var pos = Vector2(0,0)
var ray_result
var check_ray = false
var ignore = []
var hit_edge_color = Color(1,1,1,1)

func _ready():
	ignore = [self, 
				self.get_parent(),
				self.get_parent().get_node("PlayerShapeWalk"),
				self.get_parent().get_node("PlayerShapeCrunch"),
				self.get_parent().get_node("TriggerDetector")]
	pass

func CastDirection():
	
	check_ray = false
	
	var space_state = get_world_2d().direct_space_state
	
	var rad = deg2rad(angle)
	dir = Vector2(cos(rad), sin(rad)).normalized()
	target = (dir*length)
	
	ray_result = space_state.intersect_ray(self.get_parent().get_global_position(),self.get_parent().get_global_position()+self.target, self.ignore, collision_mask) 
	if ray_result:
		if ray_result.collider.is_in_group("SOLID"):
			hit_edge_color = Color(1,1,1,1)
			check_ray = true
		if ray_result.collider.is_in_group("TELEPORT"):
			hit_edge_color = Color(0,1,0,1)
			check_ray = true
		if ray_result.collider.is_in_group("ENEMY"):
			hit_edge_color = Color(1,0,0,1)
			check_ray = true
		if ray_result.collider.is_in_group("PLATFORM"):
			hit_edge_color = Color(0,1,0,1)
			check_ray = true
	
	
	if check_ray:
		target = ray_result.position
		var obj = Utils.Instantiate(Globals.pixel,target)
		obj.self_modulate = hit_edge_color
	update()
	pass
	
func _draw():
	if debug:
		draw_circle(pos, 4, laser_color)
		if check_ray: draw_circle(target-self.position, 4, hit_color)
		draw_line(pos, target-self.position, laser_color) 
		pass
	
func _process(delta):
	if Engine.is_editor_hint():
        update()
	angle = (angle + angle_offset + self.angle_step) % 360
	
	#if angle>360: angle = 0.0
	CastDirection()
	pass