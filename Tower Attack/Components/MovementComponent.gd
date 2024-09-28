extends Node
class_name MovementComponent

@export var speed:float = 0
@export var accel:float = 2

@export var character_body:CharacterBody2D

func _physics_process(delta: float) -> void:
	move(delta)


func accelerate_in_direction(new_pos:Vector2) -> void:
	character_body.velocity += character_body.global_position.direction_to(new_pos) * accel * get_physics_process_delta_time()


func move(delta:float) -> void:
	character_body.velocity = character_body.velocity.limit_length(speed)
	character_body.move_and_slide()
	decelerate(delta)

func decelerate(delta:float) -> void:
	character_body.velocity = character_body.velocity.lerp(Vector2.ZERO, 0.15*delta)
