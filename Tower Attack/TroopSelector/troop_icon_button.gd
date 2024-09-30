@tool
extends TextureButton
class_name TroopIconButton



## The textures for the troop icons when the button is not pressed
@export var icons_normal:Array[Texture2D] = []

## The textures for the troop icons when the button is pressed
@export var icons_pressed:Array[Texture2D] = []


@export var mana_cost_label:RichTextLabel

signal clicked_troop_button(scene:PackedScene, mana_cost:int)

# Keep track of the cost of the troop
@export var mana_cost:int = 0:
	set(new_val):
		mana_cost = new_val
		if mana_cost_label:
			mana_cost_label.clear()
			mana_cost_label.append_text("[center][img=30x25]res://Mana/blue_crystal_0003.png[/img]" + str(mana_cost))

var current_upgrade:int = 0:
	set(new_val):
		current_upgrade = clamp(new_val, 0, max_upgrade-1)

@onready var max_upgrade:int = len(icons_normal)

## All tiers of the troop's scenes
@export var troop_scenes:Array[PackedScene]

func _ready() -> void:
	if len(icons_normal) > 0:
		texture_normal = icons_normal[0]
	if len(icons_pressed) > 0:
			texture_pressed = icons_pressed[0]
	
	if not Engine.is_editor_hint():
		set_process(false)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		update_textures()


func upgrade() -> void:
	if current_upgrade >= max_upgrade:
		return
	current_upgrade += 1
	update_textures()

func update_textures() -> void:
	if len(icons_normal) > 0:
		texture_normal = icons_normal[current_upgrade]
	else:
		texture_normal = null
	if len(icons_pressed) > 0:
		texture_pressed = icons_pressed[current_upgrade]
	else:
		texture_pressed = null
	

func _on_pressed() -> void:
	emit_signal("clicked_troop_button", troop_scenes[current_upgrade], mana_cost)
