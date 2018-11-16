extends KinematicBody2D

var scan = [];
var hit = [];
var ignore = []
var hit_edge_color = Color(1,1,1,1)
var hit_edge_enabled = false

export var debug = false;
export (int,1,4) var ray_count = 4
export var ray_speed = [500,500,500,500]
export var ray_angle_offset = [0,90,180,270]
export var angular_speed = 50

func _ready():
	self.ignore = [self, 
				self.get_parent(),
				self.get_parent().get_node("PlayerShapeWalk"),
				self.get_parent().get_node("PlayerShapeCrunch"),
				self.get_parent().get_node("TriggerDetector")]
	
	for i in range(self.ray_count):
		self.scan.append(Globals.TLineRayCastScanner.new())
		self.hit.append(null)
		self.scan[i].SetOwner(self)
		self.scan[i].SetLength(16,96)
		self.scan[i].SetAngle(self.ray_angle_offset[i])
		self.scan[i].SetRayIgnoreList(self.ignore)
		self.scan[i].SetVisualDebug(self,self.debug)
		pass
	
	pass

# ---------------------------------------------------------
# On Update preview
# ---------------------------------------------------------
func _draw():
	for i in range(self.ray_count):
		self.scan[i].VisualDebug()		
		pass
	
func CastDirection():
	
	for i in range(self.ray_count):	
		self.hit[i] = self.scan[i].GetHitPoint()
		pass	
	pass

	
func _physics_process(delta):

	# update angle
	for i in range(self.ray_count):	
		var rot = self.scan[i].GetAngle() + self.ray_speed[i] * delta
		rot = int(rot) % 360
		self.scan[i].SetAngle(rot)
		
	CastDirection()
	for i in range(self.ray_count):
		if hit[i]: 
			hit_edge_enabled = false;
			if self.hit[i].collider.is_in_group("SOLID"):
				self.hit_edge_color = Color(1,1,1,1)
				self.hit_edge_enabled = true
				
			if self.hit[i].collider.is_in_group("TELEPORT"):
				self.hit_edge_color = Color(0,1,0,1)
				self.hit_edge_enabled = true
				
			if self.hit[i].collider.is_in_group("ENEMY"):
				self.hit_edge_color = Color(1,0,0,1)
				self.hit_edge_enabled = true
				
			if self.hit[i].collider.is_in_group("PLATFORM"):
				self.hit_edge_color = Color(0,1,0,1)
				self.hit_edge_enabled = true
			
			if self.hit_edge_enabled:
				var obj = Utils.Instantiate(Globals.pixel,hit[i].position)
				obj.self_modulate = hit_edge_color
	pass