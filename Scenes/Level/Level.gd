extends Node2D

var levels = [preload("res://Scenes/Level/LevelArrangements/LevelArrangementBase.tscn")]

func reset_picking():
	$PickingMode.show()
	$Camera2D.zoom = Vector2(1, 1)
	for i in $PickingMode.get_children():
		var pick = levels.pick_random()
		i.add_child(pick.instantiate())

func _on_button_1_pressed() -> void:
	picked(0)

func _on_button_2_pressed() -> void:
	picked(1)

func _on_button_3_pressed() -> void:
	picked(2)

func picked(button : int):
	$Level.add_child($PickingMode.get_child(button).get_child(0).duplicate())
	$PickingMode.hide()
	clear_picking()

func clear_picking():
	for i in $PickingMode.get_children():
		i.get_child(0).queue_free()
