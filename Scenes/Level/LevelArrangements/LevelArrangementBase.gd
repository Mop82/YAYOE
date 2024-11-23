extends Node2D
class_name LevelArrangement

func spawn_items() -> void:
	for i : EnemySpawner in $Enemies.get_children():
		i.update_icon()
		i.spawn()
