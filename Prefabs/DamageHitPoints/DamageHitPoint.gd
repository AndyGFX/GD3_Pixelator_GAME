extends Label

func _ready():
	
	$AnimationPlayer.play("Fly")
	print("Hit info created")
	pass
	

func _on_AnimationPlayer_animation_finished(anim_name):
	print("Hit info removed")
	get_parent().queue_free()	
	pass # replace with function body
