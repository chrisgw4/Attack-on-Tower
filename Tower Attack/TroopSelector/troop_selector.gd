extends Container
class_name TroopSelector

signal spawn_troop(troop, stats_upgrade:StatsUpgrade)

@export var upgrade_menu:FlowContainer

@export var troop_container:FlowContainer


@export var skeleton_scene:Array[PackedScene]

@export var orc_scene:Array[PackedScene]

@export var were_scene:Array[PackedScene]

@export var skeleton_button:TextureButton

@export var orc_button:TextureButton

@export var were_button:TextureButton

signal upgrade_pressed(upgrade_cost, type)

var dictionary:Dictionary = {}

func _ready() -> void:
	dictionary[skeleton_scene] = StatsUpgrade.new()
	dictionary[skeleton_scene].upgrade_cost = 110
	dictionary[skeleton_scene].cost = 10
	dictionary[orc_scene] = StatsUpgrade.new()
	dictionary[orc_scene].upgrade_cost = 120
	dictionary[orc_scene].cost = 15
	dictionary[were_scene] = StatsUpgrade.new()
	dictionary[were_scene].upgrade_cost = 150
	dictionary[were_scene].cost = 20


func _on_skeleton_button_pressed() -> void:
	emit_signal("spawn_troop", skeleton_scene[dictionary[skeleton_scene].times_upgraded].instantiate(), dictionary[skeleton_scene])


func _on_skeleton_upgrade_pressed() -> void:
	emit_signal("upgrade_pressed", dictionary[skeleton_scene].upgrade_cost, "Skeleton")

func upgrade_skeleton() -> void:
	dictionary[skeleton_scene].level_up()
	if dictionary[skeleton_scene].times_upgraded == 1:
		skeleton_button.texture_normal = load("res://TroopIcons/Skeleton2_Icon.png")
		skeleton_button.texture_pressed = load("res://TroopIcons/Skeleton2_Icon_Clicked.png")
		var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade/RichTextLabel3
		label.clear()
		label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(int(dictionary[skeleton_scene].upgrade_cost)))
	if dictionary[skeleton_scene].times_upgraded == 2:
		skeleton_button.texture_normal = load("res://TroopIcons/Skeleton_3_Icon.png")
		skeleton_button.texture_pressed = load("res://TroopIcons/Skeleton3_Icon_Clicked.png")
		var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade/RichTextLabel3
		label.clear()
		#label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(int(dictionary[skeleton_scene].upgrade_cost)))
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade.modulate = Color(1,1,1,0)

class StatsUpgrade:
	var damage_increase:float = 1.0
	var move_speed_increase:float = 1.0
	var health_increase:float = 1.0
	var times_upgraded:int = 0
	var upgrade_cost:int = 100
	var cost:int = 10
	
	func level_up() -> void:
		if times_upgraded == 2:
			return
		damage_increase += 0.75
		move_speed_increase += 0.30
		health_increase += 0.60
		times_upgraded += 1
		upgrade_cost *= 1.2




func _on_orc_button_pressed():
	emit_signal("spawn_troop", orc_scene[dictionary[orc_scene].times_upgraded].instantiate(), dictionary[orc_scene])


func _on_orc_upgrade_pressed():
	emit_signal("upgrade_pressed", dictionary[orc_scene].upgrade_cost, "Orc")

func upgrade_orc() -> void:
	dictionary[orc_scene].level_up()
	if dictionary[orc_scene].times_upgraded == 1:
		orc_button.texture_normal = load("res://TroopIcons/Orc2_Icon.png")
		orc_button.texture_pressed = load("res://TroopIcons/Orc2_Icon_Clicked.png")
		var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade/RichTextLabel3
		label.clear()
		label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(int(dictionary[orc_scene].upgrade_cost)))
	if dictionary[orc_scene].times_upgraded == 2:
		orc_button.texture_normal = load("res://TroopIcons/Orc3_Icon.png")
		orc_button.texture_pressed = load("res://TroopIcons/Orc3_Icon_Clicked.png")
		var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade/RichTextLabel3
		label.clear()
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade.modulate = Color(1,1,1,0)
		#label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(int(dictionary[orc_scene].upgrade_cost)))
	


func _on_were_button_pressed():
	emit_signal("spawn_troop", were_scene[dictionary[were_scene].times_upgraded].instantiate(), dictionary[were_scene])
	
	
func upgrade_were():
	dictionary[were_scene].level_up()
	if dictionary[were_scene].times_upgraded == 1:
		were_button.texture_normal = load("res://TroopIcons/Werebear_Icon.png")
		were_button.texture_pressed = load("res://TroopIcons/Werebear_Icon_Clicked.png")
		var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer3/WereUpgrade/RichTextLabel3
		label.clear()
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer3/WereUpgrade.modulate = Color(1,1,1,0)
		


func _on_were_upgrade_pressed():
	emit_signal("upgrade_pressed", dictionary[were_scene].upgrade_cost, "wearwolf")
