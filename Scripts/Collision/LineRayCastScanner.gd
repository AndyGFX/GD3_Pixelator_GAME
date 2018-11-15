

var raycast_ignore_list = []
var owner = null
var ray_length = 128
var ray_from = 16
var ray_angle = 0

var ray_from_pos =Vector2()
var ray_to_pos =Vector2()
var _debug = false;
var _debug_dot_size = 2
var _hit = null;

func SetLength(_from,_length):
	self.ray_from = _from
	self.ray_length = _length
	pass
	
func SetOwner(_owner):
	self.owner = _owner
	pass

func SetAngle(_angle):
	self.ray_angle = _angle
	pass
	
func SetRayIgnoreList(_object_list):
	self.raycast_ignore_list = _object_list
	pass

func GetGlobalPos(_v):
	return self.owner.get_global_position() + _v

func GetLocalPos(_v):
	return _v - self.owner.position

func GetHitPoint():
	var result = null
	
	var space_state = self.owner.get_world_2d().direct_space_state
	
	var rad = deg2rad(self.ray_angle)
	var dir = Vector2(cos(rad), sin(rad)).normalized()
	
	# calc local check point positions
	self.ray_from_pos = (dir*ray_from)
	self.ray_to_pos   = (dir*ray_from) + (dir*self.ray_length)
	
	var ray_result = space_state.intersect_ray(
		self.GetGlobalPos(self.ray_from_pos),
		self.GetGlobalPos(self.ray_to_pos), 
		self.raycast_ignore_list, 
		self.owner.collision_mask) 
	
	
	if ray_result:
		result = ray_result
	self._hit = result
	
	if self._debug: self.owner.update()
	return result
	pass

func SetVisualDebug(state):
	self._debug = state
	pass

func VisualDebug():

	self.owner.draw_line(self.ray_from_pos,self.ray_to_pos,Color(1,0,0,1))	
	self.owner.draw_circle(self.ray_from_pos, self._debug_dot_size, Color(1,0,0,1))
	self.owner.draw_circle(self.ray_to_pos, self._debug_dot_size, Color(1,0,0,1))
		
	if self._hit and self._debug:
		# draw hit point
		self.owner.draw_circle(self.GetLocalPos(self._hit.position), self._debug_dot_size, Color(0,1,0,1))
		# draw line from start to hit point
		self.owner.draw_line(self.ray_from_pos,self.GetLocalPos(self._hit.position),Color(0,1,0,1))
		# draw normal
		self.owner.draw_line(self.GetLocalPos(self._hit.position), self.GetLocalPos(self._hit.position)+(self._hit.normal*16),Color(0,1,0,1))	
		
	pass