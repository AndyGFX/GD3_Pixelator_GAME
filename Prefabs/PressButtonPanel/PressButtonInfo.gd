extends Node2D

export var animationSpeed = 2.0
var anim = null

func _ready():
	anim = get_node("AnimationPlayer");
	
func Show():
	anim.play("FadeOut",-1,self.animationSpeed)	

func Hide():
	anim.play("FadeOut",-1,-self.animationSpeed,true)	
	
	