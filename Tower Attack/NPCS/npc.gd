@tool
extends CharacterBody2D

var center_pos:Vector2 = Vector2.ZERO

@export var timer:Timer
@export var move_component:MovementComponent
@export var animation_player:AnimationPlayer

@export var animation_names:Array[String]
@export var range:float = 10:
	set(new_val):
		range = new_val
		if radius_shape.shape == null:
			radius_shape.shape = CircleShape2D.new()
		radius_shape.shape.set_radius(new_val*1.5) 

@export var radius_shape:CollisionShape2D

var new_pos_to_walk_to:Vector2 = Vector2.ZERO

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	center_pos = global_position
	choose_new_spot()
	timer.start(randf_range(4, 10))

func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if move_component.vel != Vector2.ZERO and global_position.distance_to(new_pos_to_walk_to) < 1:
			move_component.vel = Vector2.ZERO
			animation_player.play("idle")
		if global_position.distance_to(center_pos) >= range:
			choose_new_spot()


func choose_new_spot() -> void:
	new_pos_to_walk_to = center_pos+ Vector2(randf_range(-range,range), randf_range(-range, range))
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
	
