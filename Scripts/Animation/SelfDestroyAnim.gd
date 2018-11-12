extends Node2D

export var animationName = "undefined"
export var animationSpeed = 1.0
func _ready():
	
	$AnimationPlayer.play(self.animationName,-1,self.animationSpeed)
	$AnimationPlayer.get_animation(self.animationName).loop = false	
	yield($AnimationPlayer, "animation_finished") 
	queue_free()
	pass
