extends Node2D

## The node where the troop will spawn at
@export var spawn_node:Node2D

@export var castle:Castle

var wave_active:bool = false
var can_send_troops:bool = false

var round_number:int = 0:
	set(new_round):
		round_label.text = "Round: " + str(new_round) + "/" + str(max_rounds)
		round_number = new_round
		

@export var max_rounds:int = 1
@export var round_label:Label

@export var rounds_for_3_skulls:int = 0
@export var rounds_for_2_skulls:int = 0


var stop_send_troops:bool = false:
	set(new_val):
		if new_val:
			troop_delay.start()
		stop_send_troops = new_val
		

@export var troop_delay:Timer

## The direction the troop will start moving when spawning
@export var start_direction:Vector2i = Vector2i.ZERO

@export var troop_selector:TroopSelector
@export var tile_map:TileMap
@export var mana:Mana

@export var label:Label

var troop_count:int = 0:
	set(new_val):
		troop_count = new_val
		if troop_count == 0 and wave_timer.time_left == 0:
			wave_active = false
			$Fight1Music.stop()
			$Fight2Music.stop()
			$PlanMusic.play()
			if round_number >= max_rounds:
				show_lose_screen()
				return
			
			start_wave_button.show()
			label.hide()
			

func _physics_process(delta: float) -> void:
	label.text = "Time Left: " + str(int(wave_timer.time_left))
	

func _ready() -> void:
	troop_selector.connect("spawn_troop", _spawn_troop_in_game)
	troop_selector.connect("upgrade_pressed", _check_upgrade_cost)
	castle.health_component.connect("died", _show_win_screen)
	$PlanMusic.autoplay = true
	$PlanMusic.play()
	round_number = 0


var shown_win:bool = false

func _show_win_screen() -> void:
	if shown_win:
		return
	shown_win = true
	$WinLoseScreen.rounds_taken = round_number
	$WinLoseScreen.max_rounds = max_rounds
	if round_number == max_rounds and castle.health_component.current_hp > 0:
		$WinLoseScreen.skulls = 0
	elif round_number <= rounds_for_3_skulls:
		$WinLoseScreen.skulls = 3
	elif round_number <= rounds_for_2_skulls:
		$WinLoseScreen.skulls = 2
	elif round_number <= max_rounds:
		$WinLoseScreen.skulls = 1
	else:
		$WinLoseScreen.skulls = 0
	$WinLoseScreen.determine_results()

func show_lose_screen() -> void:
	pass

func _check_upgrade_cost(cost, type) -> void:
	if mana.mana < cost:
		return
	mana.mana -= cost
	if type == "Skeleton":
		troop_selector.upgrade_skeleton()
	elif type == "Orc":
		troop_selector.upgrade_orc()
	elif type =="wearwolf":
		troop_selector.upgrade_were()
	

func _spawn_troop_in_game(troop, stats_upgrade) -> void:
	if stop_send_troops:
		return
	if not can_send_troops:
		return
	if not wave_active:
		return
	if mana.mana < stats_upgrade.cost:
		return
	$MenuClick.play()
	mana.mana -= stats_upgrade.cost
	troop.global_position = spawn_node.global_position
	troop.stats.start_velocity = start_direction
	troop.stats.update_stats(stats_upgrade)
	troop.cost = stats_upgrade.cost
	tile_map.add_child(troop)
	troop.connect("death_time", _mana_increase )
	troop_count += 1
	stop_send_troops = true
	
func _mana_increase(troop) -> void:
	mana.mana += troop.cost*.6 + clamp(troop.time_alive *0.5, 0, troop.cost) #clamp(troop.time_alive *0.5, 0, 2*troop.cost)
	#print(mana.mana)
	troop_count -= 1


@export var start_wave_button:TextureButton
@export var wave_timer:Timer

func _on_start_wave_button_pressed() -> void:
	$MenuClick.play()
	label.show()
	wave_active = true
	can_send_troops = true
	start_wave_button.hide()
	wave_timer.start()
	round_number += 1
	$PlanMusic.stop()
	
	if round_number < max_rounds:
		$Fight1Music.play()
		$Fight1Music.autoplay = true
	else:
		$Fight2Music.play()
		$Fight2Music.autoplay = true


func _on_wave_timer_timeout() -> void:
	if troop_count == 0:
		wave_active = false
		$Fight1Music.stop()
		$Fight2Music.stop()
		$PlanMusic.play()
		if round_number >= max_rounds:
			_show_win_screen()
			return
		
		start_wave_button.show()
		label.hide()
		
	can_send_troops = false


func _on_troop_select_delay_timeout() -> void:
	stop_send_troops = false



func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Main Menu/main_menu.tscn"))


func _on_plan_music_finished() -> void:
	$PlanMusic.play()



func _on_fight_1_music_finished() -> void:
	$Fight1Music.play()


func _on_fight_2_music_finished() -> void:
	$Fight2Music.play()
