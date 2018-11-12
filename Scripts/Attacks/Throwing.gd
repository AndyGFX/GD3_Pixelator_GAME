extends Node


#	if event.is_action_pressed("ui_accept"):
#		var gr = granade.instance()
#		gr.set_pos(Vector2(300,200))
#
#		var dir = Vector2(0,1).rotated( throw_dir.get_global_rot())*100
#		gr.apply_impulse(Vector2(0,0),dir)

var holder = null
var key = null
var granade = null
var thrower = null
var throw_dir = null

# -----------------------------------------------------------
# Shooting class constructor
# -----------------------------------------------------------
func _init(_thrower,_key, _granade,_holder):
	thrower = _thrower
	key = _key
	granade = _granade
	holder = _holder
	throw_dir = Utils.FindNode("ThrowDirection");


func Check():

	if key.IsPressed():
		if (GameData.items.granade>0):
			var gr = granade.instance()
			gr.set_position(throw_dir.get_global_position())

			#var dir = Vector2(0,1).rotated( throw_dir.get_global_rotation())*100
			
			var dir = throw_dir.get_parent().get_scale()* throw_dir.get_cast_to()*6.0
			gr.apply_impulse(Vector2(10,-10),dir)   # <---- !!!!!
			holder.add_child(gr)
			GameData.items.granade -= 1
			pass

	pass
