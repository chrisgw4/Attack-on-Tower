extends Container
class_name TroopSelector

signal spawn_troop(troop, stats_upgrade:StatsUpgrade)

@export var upgrade_menu:FlowContainer

@export var troop_container:FlowContainer

@export var skeleton_scene:Array[PackedScene]

@export var orc_scene:Array[PackedScene]

@export var were_scene:Array[PackedScene]


@export var skeleton_button:TroopIconButton

@export var orc_button:TroopIconButton

@export var were_button:TroopIconButton

var skeleton_icon_array:Array[Texture2D] = [preload("res://TroopIcons/Skeleton2_Icon.png"), preload("res://TroopIcons/Skeleton2_Icon_Clicked.png"), preload("res://TroopIcons/Skeleton_3_Icon.png"), preload("res://TroopIcons/Skeleton3_Icon_Clicked.png")]
var orc_icon_array:Array[Texture2D] = [preload("res://TroopIcons/Orc2_Icon.png"), preload("res://TroopIcons/Orc2_Icon_Clicked.png"), preload("res://TroopIcons/Orc3_Icon.png"), preload("res://TroopIcons/Orc3_Icon_Clicked.png")]

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
	skeleton_button.connect("clicked_troop_button", _spawn_troop)
	orc_button.connect("clicked_troop_button", _spawn_troop)
	were_button.connect("clicked_troop_button", _spawn_troop)

func _spawn_troop(scene:PackedScene, cost:int):
	emit_signal("spawn_troop", scene, cost)

func _on_skeleton_button_pressed() -> void:
	emit_signal("spawn_troop", skeleton_scene[dictionary[skeleton_scene].times_upgraded], dictionary[skeleton_scene].cost)


func _on_skeleton_upgrade_pressed() -> void:
	emit_signal("upgrade_pressed", dictionary[skeleton_scene].upgrade_cost, "Skeleton")

func upgrade_skeleton() -> void:
	dictionary[skeleton_scene].level_up()
	
	skeleton_button.upgrade()
	#skeleton_button.texture_normal = skeleton_icon_array[(dictionary[skeleton_scene].times_upgraded-1) * 2]
	#skeleton_button.texture_pressed = skeleton_icon_array[(dictionary[skeleton_scene].times_upgraded-1) * 2 + 1]
	var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade/RichTextLabel3
	label.clear()
	label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(floor(dictionary[skeleton_scene].upgrade_cost)))
	if dictionary[skeleton_scene].times_upgraded == 2:
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade.modulate = Color(1,1,1,0)
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade.disabled = true
	#if dictionary[skeleton_scene].times_upgraded == 1:
		#skeleton_button.texture_normal = load("res://TroopIcons/Skeleton2_Icon.png")
		#skeleton_button.texture_pressed = load("res://TroopIcons/Skeleton2_Icon_Clicked.png")
		#var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade/RichTextLabel3
		#label.clear()
		#label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(floor(dictionary[skeleton_scene].upgrade_cost)))
	#if dictionary[skeleton_scene].times_upgraded == 2:
		#skeleton_button.texture_normal = load("res://TroopIcons/Skeleton_3_Icon.png")
		#skeleton_button.texture_pressed = load("res://TroopIcons/Skeleton3_Icon_Clicked.png")
		#var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade/RichTextLabel3
		#label.clear()
		##label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(int(dictionary[skeleton_scene].upgrade_cost)))
		#$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer/SkeletonUpgrade.modulate = Color(1,1,1,0)

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
	emit_signal("spawn_troop", orc_scene[dictionary[orc_scene].times_upgraded], dictionary[orc_scene].cost)


func _on_orc_upgrade_pressed():
	emit_signal("upgrade_pressed", dictionary[orc_scene].upgrade_cost, "Orc")

func upgrade_orc() -> void:
	dictionary[orc_scene].level_up()
	
	orc_button.upgrade()
	
	#orc_button.texture_normal = orc_icon_array[(dictionary[orc_scene].times_upgraded-1) * 2]
	#orc_button.texture_pressed = orc_icon_array[(dictionary[orc_scene].times_upgraded-1) * 2 + 1]
	
	var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade/RichTextLabel3
	label.clear()
	label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(floor(dictionary[orc_scene].upgrade_cost)))
	
	if dictionary[orc_scene].times_upgraded == 2:
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade.modulate = Color(1,1,1,0)
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade.disabled = true
	
	#if dictionary[orc_scene].times_upgraded == 1:
		#orc_button.texture_normal = load("res://TroopIcons/Orc2_Icon.png")
		#orc_button.texture_pressed = load("res://TroopIcons/Orc2_Icon_Clicked.png")
		#var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade/RichTextLabel3
		#label.clear()
		#label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(floor(dictionary[orc_scene].upgrade_cost)))
	#if dictionary[orc_scene].times_upgraded == 2:
		#orc_button.texture_normal = load("res://TroopIcons/Orc3_Icon.png")
		#orc_button.texture_pressed = load("res://TroopIcons/Orc3_Icon_Clicked.png")
		#var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade/RichTextLabel3
		#label.clear()
		#$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer2/OrcUpgrade.modulate = Color(1,1,1,0)
		#label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(int(dictionary[orc_scene].upgrade_cost)))
	


func _on_were_button_pressed():
	emit_signal("spawn_troop", were_scene[dictionary[were_scene].times_upgraded], dictionary[were_scene].cost)
	
	
func upgrade_were():
	dictionary[were_scene].level_up()
	
	were_button.upgrade()
	
	if dictionary[were_scene].times_upgraded == 1:
		#were_button.texture_normal = load("res://TroopIcons/Werebear_Icon.png")
		#were_button.texture_pressed = load("res://TroopIcons/Werebear_Icon_Clicked.png")
		var label = $HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer3/WereUpgrade/RichTextLabel3
		label.clear()
		$HFlowContainer/VFlowContainer/ScrollContainer/FlowContainer/VFlowContainer3/WereUpgrade.modulate = Color(1,1,1,0)
		


func _on_were_upgrade_pressed():
	emit_signal("upgrade_pressed", dictionary[were_scene].upgrade_cost, "wearwolf")
