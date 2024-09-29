extends Node
class_name AttackComponent

var damage:float = 0
@export var animation_player:AnimationPlayer


func attack() -> void:
	if animation_player:
		animation_player.play("attack")
		#if get_parent().get_node_or_null("SwingEffect") and randi_range(0, 100) <= 30:
			#get_parent().get_node_or_null("SwingEffect").pitch_scale = 1-randf_range(-0.4, 0.4)
			#get_parent().get_node_or_null("SwingEffect").playing = true
	
