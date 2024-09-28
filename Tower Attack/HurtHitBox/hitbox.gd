extends Area2D
class_name Hitbox

@export var attack_component:AttackComponent
@export var collision_shape:CollisionShape2D




func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.take_damage(attack_component.damage)
		get_parent().queue_free()
