extends CharacterBody2D

@export var stats:StatsComponent
@export var health_component:HealthComponent
@export var move_component:MovementComponent
@export var animation_player:AnimationPlayer
@export var hurtbox:Hurtbox

@export var attack_delay:Timer 

var cost:int = 0

var time_alive:float = 0
signal death_time(troop)
signal attack

var check_left:bool = false
var check_right:bool = false
var check_down:bool = false
var check_up:bool = false

var pos_to_check:Vector2 = Vector2.ZERO
var new_direction:Vector2

var start_attacking:bool = false

@export var hurt_animation:AnimationPlayer

func _ready() -> void:
	health_component.connect("died", _clean_up_death)
	health_component.connect("hurt", _hurt_flash)
	connect("attack", stats.attack_component.attack)

func _hurt_flash() -> void:
	$HurtSound.pitch_scale = 1 - randf_range(-0.4, 0.4)
	$HurtSound.play()
	hurt_animation.play("flash")

func _clean_up_death() -> void:
	$HurtSound.pitch_scale = 1 - randf_range(-0.4, 0.4)
	$HurtSound.play()
	emit_signal("death_time", self)
	hurt_animation.play("flash")
	hurtbox.collision_shape.set_deferred("disabled", true)
	hurtbox.queue_free()
	move_component.vel = Vector2.ZERO
	move_component.is_dead = true
	animation_player.play("death")
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), randf_range(4, 10))
	tween.play()
	
	await tween.finished
	queue_free()

func _physics_process(delta: float) -> void:
	if start_attacking:
		pos_to_check = Vector2.ZERO
		attack_delay.start()
		start_attacking = false
	if health_component.current_hp >0:
		time_alive += delta
	
	if not move_component.stop_moving:
		$SwingEffect.stop()
		
		
		
	
	if pos_to_check == Vector2.ZERO:
		return
	if check_left:
		if global_position.x < pos_to_check.x:
			global_position = pos_to_check
			check_left = false
			stats.movement_component.set_velocity(new_direction)
	if check_right:
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




func _on_attack_delay_timeout() -> void:
	#emit_signal("attack")
	if randf_range(0, 100) <= 30 and move_component.stop_moving:
		$SwingEffect.pitch_scale = 1-randf_range(-0.4, 0.4)
		$SwingEffect.play(0.07)
	if health_component.current_hp <= 0 or not move_component.stop_moving:
		return
	attack_delay.start()
	stats.attack_component.attack()
