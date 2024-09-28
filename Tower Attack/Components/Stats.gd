extends Node
class_name StatsComponent

@export var base_health_points:float = 0

@export var base_speed:float = 0

@export var base_attack_damage:float = 0

var start_velocity:Vector2 = Vector2.ZERO

@export var health_component:HealthComponent
@export var movement_component:MovementComponent
@export var attack_component:AttackComponent

func _ready() -> void:
	if health_component:
		health_component.max_hp = base_health_points
	
	if movement_component:
		movement_component.speed = base_speed
		movement_component.set_velocity(start_velocity)
	
	if attack_component:
		attack_component.damage = base_attack_damage


