extends Area2D


@export var new_direction:Vector2i = Vector2.ZERO
@export var collision_shape:CollisionShape2D

@export var check_left:bool
@export var check_right:bool
@export var check_up:bool
@export var check_down:bool

func _on_body_entered(body: Node2D) -> void:
	#body.global_position = global_position
	body.check_left = check_left
	body.check_right = check_right
	body.check_down = check_down
	body.check_up = check_up
	body.pos_to_check = global_position
	body.new_direction = new_direction
	#body.stats.movement_component.set_velocity(new_direction)
