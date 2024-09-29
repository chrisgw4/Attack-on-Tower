extends Node2D
class_name Castle

@export var health_component:HealthComponent
@export var health_bar:TextureProgressBar
@export var stats:StatsComponent


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.move_component.stop_moving = true
	body.start_attacking = true

func _ready() -> void:
	health_component.connect("hurt", _update_health_bar)
	health_component.max_hp = stats.base_health_points

func _update_health_bar() -> void:
	health_bar.value = health_component.current_hp
