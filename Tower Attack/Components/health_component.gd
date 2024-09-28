extends Node
class_name HealthComponent

signal died
signal hurt



var max_hp:float = 1:
	set(new_max):
		max_hp = new_max
		current_hp = new_max

var current_hp:float = 1:
	set(new_val):
		if new_val <= 0:
			current_hp = new_val
			emit_signal("died")
			
			return
		if new_val < current_hp:
			current_hp = new_val
			emit_signal("hurt")
		else:
			current_hp = new_val


func damage(dam:float) -> void:
	current_hp -= dam

