extends Area2D

const scn_explosion = [
	preload("res://Prefabs/Explosion/explosion_0.tscn"),
	preload("res://Prefabs/Explosion/explosion_1.tscn"),
	preload("res://Prefabs/Explosion/explosion_2.tscn")
	]



var enemy = null;
var rayLeft = null;
var rayRight = null;
var animPlayer = null;
var current_animation = ""


export var armor = 100
export var damage = 10
export var speed = 25
export var velocity = Vector2(0,0)
export var hurt_direction = Vector2(0,-10)
# ---------------------------------------------------------
# Initialize on start
# ---------------------------------------------------------
func _ready():

	enemy = get_node(".")
	rayLeft = $CastLeft
	rayRight = $CastRight
	animPlayer = $Enemy/AnimationPlayer;
	add_to_group("ENEMY")
	connect("area_entered", self, "_on_area_enter")
	connect("body_entered", self, "_on_body_enter")
	
	Start()

func set_armor(new_value):

	if is_queued_for_deletion(): return

	armor -= new_value
	Globals.ShowHitPoints(new_value, self.get_global_position())
	
	if armor <= 0:
		create_explosion()
		queue_free()
	pass


	
# ---------------------------------------------------------
# On AREA hit
# ---------------------------------------------------------
func _on_area_enter(other):
	pass
	
# ---------------------------------------------------------
# On BODY hit
# ---------------------------------------------------------
func _on_body_enter(body):

	if body.is_in_group("GRANADE"):
		set_armor(body.granadeDamage)

				
	if body.is_in_group("PLAYER"):
		GameData.Add("health",-damage);
		body.move.Hurt(hurt_direction)

# ---------------------------------------------------------
# On Fixed Update
# ---------------------------------------------------------
func _physics_process(delta):

	if velocity.x!=0:
		#switch move to left
		if (rayLeft.is_colliding() and !rayRight.is_colliding()):
			velocity.x = -velocity.x
			$Enemy/Sprite.set_scale(Vector2(-1,1))

		#switch move to right
		if (!rayLeft.is_colliding() and rayRight.is_colliding()):
			velocity.x = -velocity.x
			$Enemy/Sprite.set_scale(Vector2(1,1))

	translate(velocity * delta)

	pass

# ---------------------------------------------------------
# Create collision
# ---------------------------------------------------------
func create_explosion():

	var idx = int(round(rand_range(0,2)))
	var explosion = scn_explosion[idx].instance()
	explosion.set_position(get_position())
	Utils.FindNode("Container").add_child(explosion)
	pass

# ---------------------------------------------------------
# Play animation byname
# ---------------------------------------------------------
func PlayAnimation(anim_name):
		if current_animation != anim_name:
			animPlayer.play(anim_name)
			current_animation = anim_name


# ---------------------------------------------------------
# Start enemy movement
# ---------------------------------------------------------
func Start():
	velocity.x = speed
	PlayAnimation("Walk")

# ---------------------------------------------------------
# Stop enemy movement
# ---------------------------------------------------------
func Stop():
	velocity.x = 0
	PlayAnimation("Idle")