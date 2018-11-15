#tool
extends KinematicBody2D

export (int,0,360) var angle = 0

var scan = null;
var hit = null;

func _ready():
	self.scan = Globals.TLineRayCastScanner.new()
	self.scan.SetOwner(self)
	self.scan.SetLength(24,96)
	self.scan.SetAngle(self.angle)
	self.scan.SetRayIgnoreList([self])
	self.scan.SetVisualDebug(true)
	pass


# ---------------------------------------------------------
# On Update preview
# ---------------------------------------------------------
func _draw():	
	self.scan.VisualDebug()


# ---------------------------------------------------------
# On Update
# ---------------------------------------------------------
func _physics_process(delta):
	
	self.angle = (self.angle + 1) % 360	
	self.scan.SetAngle(self.angle )
	self.hit = self.scan.GetHitPoint()
	
	
	pass