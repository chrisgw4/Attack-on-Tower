extends CharacterBody2D
class_name Projectile

@export var move_component:MovementComponent
@export var attack_component:AttackComponent
@export var stats:StatsComponent
@export var animated_sprite:AnimatedSprite2D
@export var animation_player:AnimationPlayer
@export var hitbox:Hitbox
var target:Area2D = null

func _ready() -> void:
	move_component.speed = stats.base_speed
	#move_component.set_velocity(global_position.direction_to(target.global_position))
	hitbox.connect("hit_enemy", check_hit)
	
	if animation_player and animation_player.has_animation("travel"):
			animation_player.play("travel")

func check_hit(to_be_freed) -> void:
	if to_be_freed:
		if animation_player and animation_player.has_animation("hit"):
			move_component.stop_moving = true
			animation_player.play("hit")
		else:
			queue_free()
	elif animation_player and animation_player.has_animation("hit"):
		move_component.stop_moving = true
		animation_player.play("hit")

	

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		
		#move_component.decelerate(delta)
		move_component.set_velocity(global_position.direction_to(target.global_position))
		
		attack_component.damage = stats.base_attack_damage
		
		#move_component.accelerate_in_direction(global_position.direction_to(target.global_position))
		animated_sprite.look_at(target.global_position)
		#look_at(target.global_position)
		animated_sprite.flip_h = false
	else:
		if animation_player and animation_player.has_animation("hit"):
			move_component.stop_moving = true
			animation_player.play("hit")
		else:
			queue_free()
		
