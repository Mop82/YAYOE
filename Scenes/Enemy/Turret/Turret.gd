extends Enemy

var shake = false

func _ready() -> void:
	$Timer.start(randf_range(1, 4))

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	var amp = 10
	var freq = 4
	if shake:
		freq = 10
	if shake:
		amp = 20
	rotation_degrees = sin(time * freq) * amp

func shoot():
	var bullet = preload("res://Scenes/Enemy/Turret/Gooshot.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.look_at(player.global_position)
	bullet.global_position = global_position


func _on_timer_timeout() -> void:
	shake = true
	await get_tree().create_timer(0.5).timeout
	shake = false
	$Timer.start(randf_range(1, 4))
	
	shoot()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(area.damage)


func death():
	queue_free()