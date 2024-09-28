extends CharacterBody2D

@export var stats:StatsComponent

var check_left:bool = false
var check_right:bool = false
var check_down:bool = false
var check_up:bool = false

var pos_to_check:Vector2 = Vector2.ZERO
var new_direction:Vector2

func _physics_process(delta: float) -> void:
	if pos_to_check == Vector2.ZERO:
		return
	if check_left:
		if global_position.x < pos_to_check.x:
			global_position = pos_to_check
			check_left = false
			stats.movement_component.set_velocity(new_direction)
	if check_right:
		print("check right")
		if global_position.x > pos_to_check.x:
			global_position = pos_to_check
			check_right = false
			stats.movement_component.set_velocity(new_direction)
	if check_down:
		if global_position.y > pos_to_check.y:
			global_position = pos_to_check
			check_down = false
			stats.movement_component.set_velocity(new_direction)
	if check_up:
		if global_position.y < pos_to_check.y:
			global_position = pos_to_check
			check_up = false
			stats.movement_component.set_velocity(new_direction)


