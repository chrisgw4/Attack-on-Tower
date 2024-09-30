extends Container
class_name Mana

signal too_little_mana()

@export var mana:float = 100:
	set(new_val):
		mana = new_val
		label.clear()
		label.append_text("[img=40x40]res://Mana/blue_crystal_0003.png[/img]")
		label.append_text(str(int(mana)))
		if mana < 10:
			emit_signal("too_little_mana")
		
@export var label:RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	label.clear()
	label.append_text("[img=40x40]res://Mana/blue_crystal_0003.png[/img]")
	label.append_text(str(int(mana)))
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
