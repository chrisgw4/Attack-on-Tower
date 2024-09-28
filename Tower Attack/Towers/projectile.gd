extends CharacterBody2D
class_name Projectile

@export var move_component:MovementComponent
@export var stats:StatsComponent
@export var animated_sprite:AnimatedSprite2D
var target:Area2D = null

func _ready() -> void:
	move_component.speed = stats.base_speed
	#move_component.set_velocity(global_position.direction_to(target.global_position))
	

func _physics_process(delta: float) -> void:
	if target:
		#move_component.decelerate(delta)
		move_component.set_velocity(global_position.direction_to(target.global_position))
		
		#move_component.accelerate_in_direction(global_position.direction_to(target.global_position))
		animated_sprite.look_at(target.global_position)
		#look_at(target.global_position)
		animated_sprite.flip_h = false
		
		
