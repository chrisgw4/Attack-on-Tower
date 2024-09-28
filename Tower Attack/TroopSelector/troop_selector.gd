extends Container
class_name TroopSelector

signal spawn_troop(troop, stats_upgrade:StatsUpgrade)

@export var upgrade_menu:FlowContainer

@export var troop_container:FlowContainer


@export var skeleton_scene:PackedScene


var dictionary:Dictionary = {}

func _ready() -> void:
	dictionary[skeleton_scene] = StatsUpgrade.new()


func _on_skeleton_button_pressed() -> void:
	emit_signal("spawn_troop", skeleton_scene.instantiate(), dictionary[skeleton_scene])


func _on_skeleton_upgrade_pressed() -> void:
	dictionary[skeleton_scene].level_up()



class StatsUpgrade:
	var damage_increase:float = 1.0
	var move_speed_increase:float = 1.0
	var health_increase:float = 1.0
	
	func level_up() -> void:
		damage_increase += 0.1
		move_speed_increase += 0.2
		health_increase += 0.15
