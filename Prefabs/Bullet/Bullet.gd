extends Area2D

const scn_explosion = [
	preload("res://Prefabs/Explosion/explosion_0.tscn"),
	preload("res://Prefabs/Explosion/explosion_1.tscn"),
	preload("res://Prefabs/Explosion/explosion_2.tscn")
	] 
	
export var DAMAGE = 25
export var FireSFXName = "Shoot1"
export var ExplosionSFXName = "Explosion1"
export var bulletSpeed = 300

const TYPE = "BULLET"

var bullet_velocity = Vector2(0,0)

func _ready():	
	add_to_group("BULLET")
	connect("area_entered", self, "_on_area_enter")
	connect("body_entered", self, "_on_body_enter")
	Globals.player_sfx.Play(self.FireSFXName)
	randomize()
	pass

# ---------------------------------------------------------
# Set fire direction
# ---------------------------------------------------------
func SetFireDirection(dir):
	self.bullet_velocity = bulletSpeed * dir

# ---------------------------------------------------------
# On Update
# ---------------------------------------------------------
func _physics_process(delta):
	translate(self.bullet_velocity*delta)	

# ---------------------------------------------------------
# Create explosion on hit collision
# ---------------------------------------------------------
func create_explosion():

	Globals.player_sfx.Play(self.ExplosionSFXName)
	var idx = int(round(rand_range(0,2)))
	var explosion = scn_explosion[idx].instance()
	explosion.set_position(get_position())
	Utils.FindNode("Container").add_child(explosion)
	pass

# ---------------------------------------------------------
# Check area hit
# ---------------------------------------------------------
func _on_area_enter(other):
	if other.is_in_group("ENEMY"):
		other.set_armor(self.DAMAGE)
		create_explosion()
		queue_free()
	pass

# ---------------------------------------------------------
# Check Body hit
# ---------------------------------------------------------
func _on_body_enter(other):
	
	if other.is_in_group("SOLID"):
		create_explosion()
		queue_free()
	pass  
