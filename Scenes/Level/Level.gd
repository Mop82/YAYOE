extends Node2D

var taken_positions = []

var wave_num = 4

var wave_started = false

var enemy_array = [
	preload("res://Scenes/Enemy/Bat/Bat.tscn"),
	preload("res://Scenes/Enemy/Dasher/Dasher.tscn"),
	preload("res://Scenes/Enemy/Turret/Turret.tscn")
]

var boss_array = [
	preload("res://Scenes/Boss/Boss.tscn")
]

func start_wave():
	wave_started = true
	wave_num += 1
	taken_positions.clear()
	spawn_pillars(wave_num)
	spawn_enemies(wave_num)
	
	if wave_num % 5 == 0:
		spawn_boss(1)
	
	await get_tree().create_timer(5).timeout
	
	for i : EnemySpawner in $Spawns/Pillars.get_children():
		i.spawn()
	
	await get_tree().create_timer(2).timeout
	
	for i : EnemySpawner in $Spawns/Enemies.get_children():
		i.spawn()
	
	wave_started = false

func spawn_pillars(amt):
	var attempts = 10
	
	for i in amt:
		for t in attempts:
			var x = randi_range(0, 15)
			var y = randi_range(0, 15)
			if taken_positions.find(Vector2(x, y)) == -1: 
				var pillar = preload("res://Systems/EnemySpawner/EnemySpawner.tscn").instantiate()
				$Spawns/Pillars.add_child(pillar)
				pillar.global_position = Vector2(x, y) * 8
				pillar.spawn_item = preload("res://Scenes/Objects/Pillar/Pillar.tscn")
				pillar.type = pillar.types.object
				pillar.update_icon()
				taken_positions.append(Vector2(x, y))
				break

func spawn_enemies(amt):
	var attempts = 10
	
	for i in amt:
		for t in attempts:
			var x = randi_range(0, 15)
			var y = randi_range(0, 15)
			if taken_positions.find(Vector2(x, y)) == -1: 
				var enemy = preload("res://Systems/EnemySpawner/EnemySpawner.tscn").instantiate()
				$Spawns/Enemies.add_child(enemy)
				enemy.global_position = Vector2(x, y) * 8
				enemy.spawn_item = enemy_array.pick_random()
				enemy.type = enemy.types.enemy
				enemy.update_icon()
				taken_positions.append(Vector2(x, y))
				break


func spawn_boss(amt):
	var attempts = 10
	
	for i in amt:
		for t in attempts:
			var x = randi_range(0, 15)
			var y = randi_range(0, 15)
			if taken_positions.find(Vector2(x, y)) == -1: 
				var enemy = preload("res://Systems/EnemySpawner/EnemySpawner.tscn").instantiate()
				$Spawns/Enemies.add_child(enemy)
				enemy.global_position = Vector2(x, y) * 8
				enemy.spawn_item = boss_array.pick_random()
				enemy.type = enemy.types.boss
				enemy.update_icon()
				taken_positions.append(Vector2(x, y))
				break

func _process(delta: float) -> void:
	if $Spawns/Enemies.get_child_count() == 0 and !wave_started:
		for i in $Spawns/Pillars.get_children():
			i.queue_free()
		start_wave()
