extends Enemy

var time = 0.0

var current_bullet_rot = 0

func _process(delta: float) -> void:
	time += delta
	$Boss.scale.x = abs(sin(time)) + 1.0
	$Boss.scale.y = abs(sin(time)) + 1.0
	$Boss.rotation_degrees += 7
	$Eye.rotation_degrees -= 2
	

func damage_anim():
	var bloodstain = preload("res://Scenes/FX/bloodstain.tscn").instantiate()
	get_parent().get_parent().add_child(bloodstain)
	bloodstain.global_position = global_position
	var scale_ = randf_range(3, 5)
	bloodstain.scale = Vector2(scale_, scale_)
	$SFX/Hurt.pitch_scale = randf_range(1.5, 2.5)
	$SFX/Hurt.play()

func fire_bullet():
	$ROT.rotation_degrees = current_bullet_rot
	var bullet = preload("res://Scenes/Enemy/Mirror/MirrorBullet.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $ROT/FirePos.global_position
	bullet.global_rotation = $ROT.global_rotation
	current_bullet_rot += 30

func _on_timer_timeout() -> void:
	$Timer.start()
	$SFX/Weird.pitch_scale = randf_range(3.5, 4.5)
	$SFX/Weird.play()
	fire_bullet()


func death():
	level.virtue_enemy_death()
	queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(area.damage)
