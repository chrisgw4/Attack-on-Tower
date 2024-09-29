extends Control


@export var level_select:PackedScene
@export var tutorial:PackedScene

# When the sliding bar is changed the volume will change
func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

# When the sliding bar is changed the volume will change
func _on_sound_effects_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


# Takes you to the level select screen when the button is pressed
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_select)


# Takes you to the tutorial when the button is pressed
func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_packed(tutorial)


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()
