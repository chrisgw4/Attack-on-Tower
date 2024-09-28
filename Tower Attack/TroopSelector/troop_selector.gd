extends Container
class_name TroopSelector

signal spawn_troop(troop, stats_upgrade:StatsUpgrade)

@export var upgrade_menu:FlowContainer

@export var troop_container:FlowContainer


@export var skeleton_scene:Array[PackedScene]

@export var skeleton_button:TextureButton
var dictionary:Dictionary = {}

func _ready() -> void:
	dictionary[skeleton_scene] = StatsUpgrade.new()


func _on_skeleton_button_pressed() -> void:
	emit_signal("spawn_troop", skeleton_scene[dictionary[skeleton_scene].times_upgraded].instantiate(), dictionary[skeleton_scene])


func _on_skeleton_upgrade_pressed() -> void:
	dictionary[skeleton_scene].level_up()
	if dictionary[skeleton_scene].times_upgraded == 1:
		skeleton_button.texture_normal = load("res://TroopIcons/Skeleton2_Icon.png")
		skeleton_button.texture_pressed = load("res://TroopIcons/Skeleton2_Icon_Clicked.png")
	



class StatsUpgrade:
	var damage_increase:float = 1.0
	var move_speed_increase:float = 1.0
	var health_increase:float = 1.0
	var times_upgraded:int = 0
	
	func level_up() -> void:
		if times_upgraded == 2:
			return
		damage_increase += 0.75
		move_speed_increase += 0.30
		health_increase += 0.60
		times_upgraded += 1
