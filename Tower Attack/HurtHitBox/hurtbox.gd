extends Area2D
class_name Hurtbox

@export var health_component:HealthComponent
@export var collision_shape:CollisionShape2D


func take_damage(damage:float) -> void:
	health_component.damage(damage)
