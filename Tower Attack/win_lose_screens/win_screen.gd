extends CanvasLayer


var rounds_taken:int = 0
var max_rounds:int = 0

var skulls:int = 0

@onready var outcome_label:Label = $CenterContainer/HFlowContainer/Label2
@onready var rounds_label:Label = $CenterContainer/HFlowContainer/Label

var skull_gold:Texture2D = preload("res://main_menu/gold_meduim.png")
var skull_empty:Texture2D = preload("res://main_menu/empty_skull.png")

@export var skull_container:HFlowContainer

func determine_results(soft_locked:bool = false) -> void:
	print("determined")
	if soft_locked:
		outcome_label.text = "You Soft Locked Yourself"
		$LostSoundEffect.play()
	elif skulls == 0:
		outcome_label.text = "You Lose"
		$LostSoundEffect.play()
	else:
		outcome_label.text = "You Win"
		$WinSoundEffect.play()
		
	
	if not soft_locked:
		rounds_label.text = "It took you " + str(rounds_taken) + "/" + str(max_rounds) + " Rounds"
	else:
		rounds_label.text = "Try managing your mana better next time!"
	$CenterContainer/HFlowContainer/Label3.text = "You got " + str(skulls) + " skulls"
	show()
	
	var temp_skulls = skulls
	
	
	for i in range(3):
		await get_tree().create_timer(0.45).timeout
		
		if temp_skulls > 0:
			var text_rect:TextureRect = TextureRect.new()
			text_rect.texture = skull_gold
			temp_skulls -= 1
			skull_container.add_child(text_rect)
			$SkullSound.play()
			$SkullSound.pitch_scale += 0.5
		else:
			var text_rect:TextureRect = TextureRect.new()
			text_rect.texture = skull_empty
			temp_skulls -= 1
			skull_container.add_child(text_rect)
			$SkullLossSound.play()
			$SkullLossSound.pitch_scale -= 0.25
		

	


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Main Menu/main_menu.tscn"))
