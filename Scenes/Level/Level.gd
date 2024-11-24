extends Node2D

var taken_positions = []

func start_wave():
	taken_positions.clear()
	spawn_pillars(10)

func spawn_pillars(amt):
	var attempts = 10
	
	for i in amt:
		for t in attempts:
			var x = randi_range(1, 16)
			var y = randi_range(1, 16)
			if taken_positions.find(Vector2(x, y)) == null:
				var pillar = preload("res://Systems/EnemySpawner/EnemySpawner.tscn").instantiate()
				pillar.global_position = Vector2(x, y) * 8
				pillar.spawn_item = preload("res://Scenes/Objects/Pillar/Pillar.tscn")
				pillar.type = pillar.types.object
				pillar.update_icon()
				taken_positions.append(Vector2(x, y))
				break
