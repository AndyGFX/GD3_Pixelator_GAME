var animPlayer = null
var animation_state = Globals.eAnimState.IDLE
var current_animation = Globals.eAnimState.IDLE
var _anim_name = ""

# -----------------------------------------------------------
# AnimationState class Contructor
# -----------------------------------------------------------
func _init(anim):
	animPlayer = anim

# -----------------------------------------------------------
# Check and return animation state from movement controller
# -----------------------------------------------------------
func GetState(moveControl):

	var inMove = moveControl.velocity.x!=0;

	# if is in move
	if inMove:
		# RIGHT 
		if moveControl.velocity.x > 0:
			# => set sprite orientation to RIGTH
			moveControl.object.get_child(0).set_scale(Vector2(1,1))
			
		if moveControl.velocity.x < 0:
			# => set sprite orientation to LEFT
			moveControl.object.get_child(0).set_scale(Vector2(-1,1))
			
	
	if moveControl.isOnGround:
		if moveControl.velocity.x!=0:
			if !moveControl.object.is_on_wall():
				if moveControl.inCrunch:
					animation_state = Globals.eAnimState.CRUNCHWALK
				else:
					animation_state = Globals.eAnimState.WALK
		else:
			if moveControl.inCrunch:
				animation_state = Globals.eAnimState.CRUNCH
			else:
				animation_state = Globals.eAnimState.IDLE
	else:
		if moveControl.velocity.y>0:
			animation_state = Globals.eAnimState.FALL
			
	if moveControl.jumping and moveControl.velocity.y<0: 
		animation_state = Globals.eAnimState.JUMP
	
	if moveControl.inHurt: animation_state = Globals.eAnimState.HURT
	
	return animation_state

# -----------------------------------------------------------
# Play animation by state
# before you need call Check method
# -----------------------------------------------------------
func Play(state):
	
	if state==Globals.eAnimState.IDLE: _anim_name = "Idle"
	if state==Globals.eAnimState.WALK: _anim_name = "Walk"
	if state==Globals.eAnimState.JUMP: _anim_name = "Jump"
	if state==Globals.eAnimState.FALL: _anim_name = "Fall"
	if state==Globals.eAnimState.HURT: _anim_name = "Hurt"
	if state==Globals.eAnimState.CRUNCH: _anim_name = "Crunch"
	if state==Globals.eAnimState.CRUNCHWALK: _anim_name = "CrunchWalk"
	
	if current_animation != animation_state:
		animPlayer.play(_anim_name)
		current_animation = animation_state
	
	