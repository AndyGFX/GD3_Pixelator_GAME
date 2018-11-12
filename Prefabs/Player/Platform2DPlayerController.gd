extends KinematicBody2D

# preload used classes
var cMove = preload("res://Scripts/Movement/MovePlatformer.gd")
var cInput = load("res://Scripts/Input/InputManager.gd")
var cAnimState = preload("res://Scripts/Movement/AnimationState.gd")
var cShooting = preload("res://Scripts/Attacks/Shooting.gd")
var cThrowing  = preload("res://Scripts/Attacks/Throwing.gd")

# exports to inspector
export var playerMaxSpeed = 200
export var acceleration = 0.2
export var jumpForce = 200
export var jumpCount = 2

# declare instances

var key_left = null
var key_right= null
var key_jump= null
var key_crunch= null
var key_fire = null
var key_throw = null

var player = null
var move = null
var anim = null
var fire = null
var throw = null

var btn_info = null
var msg_info = null
var container = null
var throw_dir = null

# signal for update viewport
signal moveSignal

# resize gizmo to player sprite size ()
func _get_item_rect():
    return get_node("PlayerAnimation/Sprite").get_item_rect()

# ---------------------------------------------------------
# INITIALIZE ON START
# ---------------------------------------------------------
func _ready():

	add_to_group("PLAYER")
	
	# find container instance in scene
	container =  Utils.FindNode("Container")

	# create container instance in scene if missing
	if !container:
		container = Node2D.new();
		container.set_name("Container")
		get_parent().call_deferred("add_child",container)
		print("Container created ...")


	# preload Inventory data
	#Inventory.Load();

	#create input control
	key_left = cInput.new("key_left"); container.add_child(key_left)
	key_right = cInput.new("key_right"); container.add_child(key_right)
	key_jump = cInput.new("key_jump"); container.add_child(key_jump)
	key_fire = cInput.new("key_fire"); container.add_child(key_fire)
	key_crunch = cInput.new("key_down"); container.add_child(key_crunch)
	key_throw = cInput.new("key_throw"); container.add_child(key_throw)

	# get player object

	player = get_node(".")

	# create platformer2D movement controller

	move = cMove.new(player, key_left, key_right, key_jump, key_crunch, playerMaxSpeed, acceleration, jumpForce, jumpCount)

	# create AnimationState class

	anim = cAnimState.new(get_node("Body/PlayerAnimation/AnimationPlayer"))

	# create shooting instance and bullet container

	var fire_pivot = get_node("Body/FireOrigin_RIGHT")
	fire = cShooting.new(move, key_fire,Globals.bullet_prefab,container,fire_pivot,false)
	throw = cThrowing.new(move,key_throw,Globals.granade_prefab,container)
	

	#disable rapid fire

	fire.RapidFire(false)

	# create teleport button info instance
	btn_info = Globals.btn_info_panel.instance()
	btn_info.set_global_position(Vector2(0,-5000));
	container.add_child(btn_info)

	# create message info panel instance
	msg_info = Globals.msg_info_panel.instance()
	msg_info.set_global_position(Vector2(0,-5000))
	container.add_child(msg_info)
	
	# prepare inventory/gamedata to default values (remove when you need reset items amount)
	
	GameData.Set('coins',0)
	GameData.Set('health',50)
	GameData.Set('ammo',100)
	GameData.Set('granade',9)
	
	#reset saved player game data
	GameData.Save()

	# get sound fx library for player
	Globals.player_sfx = Utils.FindNode("SoundFXPlayer")

	# respawn play at 'start_point'
	Respawn()

	# Execute transition
	# var transition = Utils.find_node("HUD").get_node("TransitionScreen")
	# transition.Start(Globals.TO_TRANSPARENT)
	pass


# -----------------------------------------------------------
# Respawn player position on level start if exist entity GAME_PlayerStart in scene
# -----------------------------------------------------------
func Respawn():
	var spawn_point = Utils.FindNode("StartPoint")
	if spawn_point:
		spawn_point.Respawn(self)

# ---------------------------------------------------------
# FIXED UPDATE LOOP
# ---------------------------------------------------------
func _physics_process(delta):

	# realize platformer movement
	move.Apply(delta)

	# get animation state and store result to global variable for easy access from any code
	var playerAnimState = anim.GetState(move)

	# play animation
	anim.Play(playerAnimState)

	# check shooting
	fire.Check()
	
	# check throwing
	throw.Check()
	
	# update viewport position
	#if move.inMotion: emit_signal("moveSignal")


func _exit_tree():
	GameData.Save();
	pass

# ---------------------------------------------------------
# ON ENTER TRIGGER callback for scene entities
# ---------------------------------------------------------
func _on_TriggerDetector_area_entered( area ):

	# | pickup COIN
	# -----------------------------------------------------
	if area.has_method('PickupCoin'): area.PickupCoin()

	# | pickup AMMO
	# -----------------------------------------------------
	if area.has_method('PickupAmmo'): area.PickupAmmo()

	# | pickup GRANADE
	# -----------------------------------------------------
	if area.has_method('PickupGranade'): area.PickupGranade()
	
# 	# | pickup KEY
# 	# -----------------------------------------------------
# 	if area.has_method('PickupKey'): area.PickupKey()

	# | pickup HEALTH
	# -----------------------------------------------------
	if area.has_method('PickupHealth'): area.PickupHealth()


	# | show message info on enter trigger zone
	# -----------------------------------------------------
	if area.has_method('EnterToMsgZone'):
		msg_info.set_global_position(area.get_global_position()+area.panel_offset)
		msg_info.Show(area.info_text)
		area.EnterToMsgZone()

	# | teleport to target door when player press 'key_up'
	# -----------------------------------------------------
	if area.has_method('Teleport'):
		btn_info.set_global_position(area.get_global_position())
		btn_info.Show()
		area.Teleport(player)

# 	# | Pickup timelimited jump force
# 	# -----------------------------------------------------
# 	if area.has_method('PickupPowerUpJump'):

# 		# setup powerup
# 		var jump = Globals.powerup_jump.instance()
# 		jump.Start(move,container,area.time_to_off,area.new_jump_force)

# 		# remove powerup
# 		area.PickupPowerUpJump()

# 	# | Pickup timelimited speed
# 	# -----------------------------------------------------
# 	if area.has_method('PickupPowerUpSpeed'):

# 		# setup powerup
# 		var speed = Globals.powerup_speed.instance()
# 		speed.Start(move,container,area.time_to_off,area.new_speed)

# 		# remove powerup
# 		area.PickupPowerUpSpeed()

# 	# | Pickup timelimited gravity
# 	# -----------------------------------------------------
# 	if area.has_method('PickupPowerUpGravity'):

# 		# setup powerup
# 		var grav = Globals.powerup_gravity.instance()
# 		grav.Start(move,container,area.time_to_off,area.new_gravity)

# 		# remove powerup
# 		area.PickupPowerUpGravity()
	
# 	# | Pickup timelimited gravity
# 	# -----------------------------------------------------
# 	if area.has_method('EnterToEndPoint'):
# 		var transition = Utils.find_node("HUD").get_node("TransitionScreen")
# 		transition.Start(Globals.TO_BLACK)
# 		yield(Utils.create_timer(1), "timeout") 
# 		area.EnterToEndPoint()
		
 # ---------------------------------------------------------
 # ON EXIT TRIGGER callback for scene entities
 # ---------------------------------------------------------
func _on_TriggerDetector_area_exited(area):

	# reset teleport to target when player exit from area and key wasn't pressed
	if area.has_method('ResetTeleport'):
		btn_info.Hide()
		area.ResetTeleport()

	# show message info on enter trigger zone
	if area.has_method("ExitFromMsgZone"):
		msg_info.Hide()
		

