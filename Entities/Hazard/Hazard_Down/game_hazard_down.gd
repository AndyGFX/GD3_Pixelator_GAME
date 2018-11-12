extends Area2D

var item_typ = "hazard"
var enemy = null;

export var hurt_direction = Vector2(0,-10)
export var damage = 10
export var removeOnHit = false

func _ready():
	enemy = get_node(".")
	#set_fixed_process(true)
	add_to_group("ENEMY")
	connect("area_entered",self,"_on_area_entered")
	connect("body_entered",self,"_on_body_entered")
	pass


# ---------------------------------------------------------
# On AREA hit
# ---------------------------------------------------------
func _on_area_entered(other):
	
	pass
	
# ---------------------------------------------------------
# On BODY hit
# ---------------------------------------------------------
func _on_body_entered(body):
	
	if body.is_in_group("PLAYER"):
		GameData.Add("health",-damage);
		body.move.Hurt(hurt_direction)
		if removeOnHit: queue_free()	
	pass

