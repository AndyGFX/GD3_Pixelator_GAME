extends Node

# Movement facing state
enum eFacing { TO_LEFT, TO_RIGHT}

enum eDirection { IDLE = 0,TO_LEFT = -1, TO_RIGHT=1, TO_UP = -1, TO_DOWN = 1 }

# Action state
#enum eActionState { FIRE, THROW, STAB, USE }

# Animation state
enum eAnimState { IDLE, WALK, JUMP, FALL, DIE, HURT, CLIMB, OBSTACLE, CRUNCH, CRUNCHWALK }

# screen transition mode
enum eTransitionMode { NONE,TO_BLACK,TO_TRANSPARENT}

# ---------------------------------------------------------------------------
# GAME data
# ---------------------------------------------------------------------------
var coins = 0;
var health = 0;
var items = {};

# ---------------------------------------------------------------------------
# GAME prefabs 
# ---------------------------------------------------------------------------

# info panels prefabs
var msg_info_panel = preload("res://Prefabs/MessagePanel/MessageInfoPanel.tscn")
var btn_info_panel = preload("res://Prefabs/PressButtonPanel/ButtonPressPanel.tscn")

# powerups

# bullet prefab for firing
onready var bullet_prefab = preload("res://Prefabs/Bullet/Bullet.tscn")
onready var granade_prefab = preload("res://Prefabs/Granade/Granade_0.tscn")

# Sound FX player
var player_sfx = null

# show damage hit points
const hit_point = preload("res://Prefabs/DamageHitPoints/DamageHitPoint.tscn")

#pickup animation
const pickup_anim = preload("res://Prefabs/PickupItems/PickupAnimation/PickupItemAnimation.tscn")

# ---------------------------------------------------------
# Show flying hit points on enemy
# ---------------------------------------------------------
func ShowHitPoints(val,pos):
	var container =  Utils.FindNode("Container")
	var hit = hit_point.instance()
	hit.get_node("Label").set_text(str(-val))	
	hit.set_position(pos)
	container.add_child(hit)
	pass

# ---------------------------------------------------------------------------
# GAME Levels
# ---------------------------------------------------------------------------

