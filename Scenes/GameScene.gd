extends Node2D

var highest_wave = 0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var child_pick = randi_range(0, 2)
	$Music.get_child(child_pick).play()

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

func play_click():
	$Click.play()

#Magic Cat Adventures in Dangerous Dungeons where Demons Lie


func _on_music_1_finished() -> void:
	$Music/Music2.play()


func _on_music_2_finished() -> void:
	$Music/Music3.play()


func _on_music_3_finished() -> void:
	$Music/Music1.play()
