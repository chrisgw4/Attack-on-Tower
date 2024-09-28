extends Container
class_name TroopSelector

signal spawn_troop(troop)

@export var upgrade_menu:FlowContainer

@export var troop_container:FlowContainer


@export var skeleton_scene:PackedScene



func _on_texture_button_2_pressed() -> void:
	emit_signal("spawn_troop", skeleton_scene.instantiate())
