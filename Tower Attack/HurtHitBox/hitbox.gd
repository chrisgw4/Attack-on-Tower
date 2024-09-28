extends Area2D
class_name Hitbox

@export var attack_component:AttackComponent
@export var collision_shape:CollisionShape2D

signal hit_enemy(to_be_freed)
var num_enemies_hit:int = 0
@export var max_num_enemies_hit:int = 1



func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox and num_enemies_hit < max_num_enemies_hit:
		area.take_damage(attack_component.damage)
		num_enemies_hit += 1
		emit_signal("hit_enemy", num_enemies_hit >= max_num_enemies_hit)
		
