extends RigidBody2D

const scn_explosion = [
	preload("res://Prefabs/Explosion/explosion_0.tscn"),
	preload("res://Prefabs/Explosion/explosion_1.tscn"),
	preload("res://Prefabs/Explosion/explosion_2.tscn")
	]

export var granadeDamage = 25
export var ExplosionSFXName = "Explosion1"

func _ready():	
	connect("body_entered", self, "_on_body_enter")
	add_to_group("GRANADE")
	pass
	

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
# Check Body hit
# ---------------------------------------------------------
func _on_body_enter(other):		
	
	if other.is_in_group("SOLID"):
		create_explosion()
		queue_free()
	pass
	
	if other.is_in_group("ENEMY"):
		create_explosion()
		queue_free()
		# your code here ...
	pass	


