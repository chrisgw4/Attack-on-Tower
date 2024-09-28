extends Node
class_name AttackComponent

var damage:float = 0
@export var animation_player:AnimationPlayer


func attack() -> void:
	if animation_player:
		animation_player.play("attack")
	
