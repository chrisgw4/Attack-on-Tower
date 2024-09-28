extends Area2D


@export var new_direction:Vector2i = Vector2.ZERO
@export var collision_shape:CollisionShape2D



func _on_body_entered(body: Node2D) -> void:
	body.global_position = global_position
	body.stats.movement_component.set_velocity(new_direction)
