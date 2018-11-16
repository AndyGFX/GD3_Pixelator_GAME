extends KinematicBody2D

var scan = [];
var hit = [];
var ignore = []

export var debug = false;
export var ray_count = 4
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
		self.scan[i].SetAngle(i*90+45)
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
		var rot = self.scan[i].GetAngle() + self.angular_speed * delta
		rot = int(rot) % 360
		self.scan[i].SetAngle(rot)
		
	CastDirection()
	for i in range(self.ray_count):
		if hit[i]: 
			Utils.Instantiate(Globals.pixel,hit[i].position)
	pass