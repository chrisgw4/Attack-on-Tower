extends Control


@export var levels:FlowContainer




func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Main Menu/main_menu.tscn"))


func _on_hard_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Levels/level_1.tscn"))


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Main Menu/main_menu.tscn"))
