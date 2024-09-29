extends Node
class_name MovementComponent

var speed:float = 0
@export var accel:float = 2

@export var character_body:CharacterBody2D
@export var animation_player:AnimationPlayer
@export var animated_sprite:AnimatedSprite2D

var is_dead:bool = false
var stop_moving:bool = false


var vel:Vector2 = Vector2.ZERO:
	set(new_val):
		
		vel = new_val
		
		if vel.x > 0:
			animated_sprite.flip_h = false
		elif vel.x < 0:
			animated_sprite.flip_h = true
		
		


func _physics_process(delta: float) -> void:
	move()


func set_velocity(velocity:Vector2) -> void:
	vel = (velocity*speed)

func accelerate_in_direction(new_pos:Vector2) -> void:
	vel += character_body.global_position.direction_to(new_pos) * accel * get_physics_process_delta_time()


func move() -> void:
	if is_dead or stop_moving:
		return
	if vel == Vector2.ZERO:
		return
	if animation_player:
		animation_player.play("walk")
	character_body.velocity = vel.limit_length(speed)
	character_body.move_and_slide()
	#decelerate(delta)

func decelerate(delta:float) -> void:
	vel.x = lerpf(vel.x, 0, 15*delta)
	vel.y = lerpf(vel.y, 0, 15*delta)
	#vel = vel.lerp(Vector2.ZERO, 15*delta)
