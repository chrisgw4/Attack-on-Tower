extends Node2D


@export var animation_player:AnimationPlayer
@export var animated_sprite:AnimatedSprite2D
@export var area_range:Area2D
@export  var attack_component:AttackComponent

@export var projectile:PackedScene

var attack_target:Area2D = null

signal attack

func _ready() -> void:
	animation_player.play("idle")
	attack.connect(attack_component.attack)


func _on_attack_delay_timeout() -> void:
	var array = area_range.get_overlapping_areas()
	if len(array) > 0:
		if array[0].global_position.x < global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
		emit_signal("attack")
		attack_target = array[0]
	else:
		attack_target = null
		animation_player.play("idle")

func shoot_projectile() -> void:
	var temp:Projectile = projectile.instantiate()
	temp.global_position = global_position
	temp.target = attack_target
	get_tree().current_scene.add_child(temp)

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
