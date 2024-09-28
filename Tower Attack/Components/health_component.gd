extends Node
class_name HealthComponent

signal died

@export var max_hp:float = 0:
	set(new_max):
		max_hp = new_max
		current_hp = new_max

@onready var current_hp = max_hp:
	set(new_val):
		if new_val <= 0:
			emit_signal("died")


func damage(dam:float) -> void:
	current_hp -= dam

