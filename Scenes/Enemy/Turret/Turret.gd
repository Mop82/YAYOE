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

func damage_anim():
	var bloodstain = preload("res://Scenes/FX/bloodstain.tscn").instantiate()
	get_parent().get_parent().add_child(bloodstain)
	bloodstain.global_position = global_position
	var scale_ = randf_range(1.6, 2)
	bloodstain.scale = Vector2(scale_, scale_)
	$SFX/Hurt.pitch_scale = randf_range(1.5, 2.5)
	$SFX/Hurt.play()

func _on_timer_timeout() -> void:
	shake = true
	await get_tree().create_timer(0.5).timeout
	shake = false
	$Timer.start(randf_range(1, 4))
	
	shoot()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(area.damage)


func death():
	level.normal_enemy_death()
	queue_free()
