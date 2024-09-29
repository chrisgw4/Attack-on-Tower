extends CharacterBody2D

@export var center:Node2D

@export var timer:Timer
@export var move_component:MovementComponent
@export var animation_player:AnimationPlayer

@export var animation_names:Array[String]
@export var range:float = 10

var new_pos_to_walk_to:Vector2 = Vector2.ZERO

func _ready() -> void:
	choose_new_spot()
	timer.start(randf_range(4, 10))

func _physics_process(delta: float) -> void:
	if global_position.distance_to(new_pos_to_walk_to) < 0.5 and move_component.vel != Vector2.ZERO:
		move_component.vel = Vector2.ZERO
		animation_player.play("idle")
	

func choose_new_spot() -> void:
	new_pos_to_walk_to = center.global_position + Vector2(randf_range(-range,range), randf_range(-range, range))
	move_component.set_velocity(global_position.direction_to(new_pos_to_walk_to))


func _on_timer_timeout() -> void:
	if randi_range(0, 100) < 40:
		animation_player.play(animation_names.pick_random())
		move_component.vel = Vector2.ZERO
		
		await animation_player.animation_finished
		animation_player.play("idle")
	else:
		choose_new_spot()
	timer.start(randf_range(4, 10))
	
