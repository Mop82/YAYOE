extends Node2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func start_pressed():
	var new_level = preload("res://Scenes/Level/Level.tscn").instantiate()
	$Level.add_child(new_level)
	new_level.start_wave()
	$Menu.hide()

func _process(delta: float) -> void:
	$Crosshair.global_position = get_global_mouse_position()
