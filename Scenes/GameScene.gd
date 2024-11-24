extends Node

func start_pressed():
	var new_level = preload("res://Scenes/Level/Level.tscn").instantiate()
	$Level.add_child(new_level)
	new_level.start_wave()
	$Menu.hide()
