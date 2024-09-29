extends Node2D


@export var health_component:HealthComponent
@export var health_bar:TextureProgressBar
@export var stats:StatsComponent


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.move_component.stop_moving = true
	body.start_attacking = true

func _ready() -> void:
	health_component.connect("hurt", _update_health_bar)
	health_component.connect("died", _died)
	health_component.max_hp = stats.base_health_points
	health_bar.max_value = health_component.max_hp
	health_bar.value = health_bar.max_value

func _died() -> void:
	queue_free()
	for i in $Area2D.get_overlapping_bodies():
		i.move_component.stop_moving = false
		i.start_attacking = false

func _update_health_bar() -> void:
	health_bar.value = health_component.current_hp
