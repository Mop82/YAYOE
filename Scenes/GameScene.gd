extends Node2D

var highest_wave = 0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func start_pressed():
	var new_level = preload("res://Scenes/Level/Level.tscn").instantiate()
	$Level.add_child(new_level)
	new_level.start_wave()
	$Menu.hide()


func tutorial_pressed():
	var new_level = preload("res://Scenes/Level/tutorail.tscn").instantiate()
	$Level.add_child(new_level)
	$Menu.hide()

func _process(delta: float) -> void:
	$Menu.highest_wave = highest_wave
	$Crosshair.global_position = get_global_mouse_position()

func reset_menu():
	$Menu.show()
	$Level.get_child(0).queue_free()

#Magic Cat Adventures in Dangerous Dungeons where Demons Lie
