extends Control

var time = 0.0

var highest_wave = 0

func _process(delta: float) -> void:
	time += delta
	$Label.rotation_degrees = sin(time * 3) * 15
	$wavenum.text = str(highest_wave)

func _on_start_pressed() -> void:
	get_parent().start_pressed()
	

func _on_start_3_pressed() -> void:
	$CREDITS.visible = !$CREDITS.visible


func _on_start_2_pressed() -> void:
	get_parent().tutorial_pressed()
