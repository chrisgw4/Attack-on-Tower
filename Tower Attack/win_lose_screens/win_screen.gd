extends CanvasLayer


var rounds_taken:int = 0
var max_rounds:int = 0

var skulls:int = 0

@onready var outcome_label:Label = $CenterContainer/VFlowContainer/HFlowContainer/Label2
@onready var rounds_label:Label = $CenterContainer/VFlowContainer/HFlowContainer/Label

func determine_results() -> void:
	if skulls == 0:
		outcome_label.text = "You Lose"
	else:
		outcome_label.text = "You Win"
	
	rounds_label.text = "It took you " + str(rounds_taken) + "/" + str(max_rounds) + " Rounds"
	
	$CenterContainer/VFlowContainer/HFlowContainer/Label3.text = "You got " + str(skulls) + " skulls"
	show()
	
