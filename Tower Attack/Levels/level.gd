extends Node2D

## The node where the troop will spawn at
@export var spawn_node:Node2D

## The direction the troop will start moving when spawning
@export var start_direction:Vector2i = Vector2i.ZERO

@export var troop_selector:TroopSelector
@export var tile_map:TileMap
@export var mana:Mana

func _ready() -> void:
	troop_selector.connect("spawn_troop", _spawn_troop_in_game)
	

func _spawn_troop_in_game(troop, stats_upgrade) -> void:
	troop.global_position = spawn_node.global_position
	troop.stats.start_velocity = start_direction
	troop.stats.update_stats(stats_upgrade)
	tile_map.add_child(troop)
	troop.connect("death_time", _mana_increase )
	
func _mana_increase(troop) -> void:
	mana.mana += troop.time_alive *0.5
	print(mana.mana)
	
