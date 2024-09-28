extends Node2D

## The node where the troop will spawn at
@export var spawn_node:Node2D

## The direction the troop will start moving when spawning
@export var start_direction:Vector2i = Vector2i.ZERO

@export var troop_selector:TroopSelector
@export var troops:Node2D

func _ready() -> void:
	troop_selector.connect("spawn_troop", _spawn_troop_in_game)
	

func _spawn_troop_in_game(troop) -> void:
	troop.global_position = spawn_node.global_position
	troop.stats.start_velocity = start_direction
	troops.add_child(troop)
	
