extends TextureRect
@export var label:RichTextLabel
var text_index=0
var dialogue:Array[String] = ["Well hello my apprentice, thank you for joining me today! I'll be showing you the ropes!","Your Job is to destroy the \"hero's\" tower!", "You'll do this by sending troops, but beware the heroes will try to stop you!", "Troops cost mana, that is the number in the top left.", "The longer a troop is alive the more mana you'll get once they die.", "Manage your mana carefully, my dear apprentice.", "You'll loose if you can't destroy the tower within the round limit.", "Deploy troops by clicking on the icon of the troops in the top right!", "You'll notice the upgrade buttons beneath the icons! That will level up that troop!", "Feel free to experiment with different orders of troops, it might be key to winning!", "Now go, and show those heroes that you mean buisness!!!"]

signal text_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	label.append_text(dialogue[text_index])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	
	label.clear()
	text_index+=1
	if text_index == len(dialogue):
		emit_signal("text_finished")
		queue_free()
		return
	label.append_text(dialogue[text_index])
