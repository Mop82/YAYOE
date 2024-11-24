extends Enemy

var time = 0.0

var current_bullet_rot = 0

func _process(delta: float) -> void:
	time += delta
	$Boss.scale.x = abs(sin(time)) + 1.0
	$Boss.scale.y = abs(sin(time)) + 1.0
	$Boss.rotation_degrees += 7
	$Eye.rotation_degrees -= 2
	

func fire_bullet():
	$ROT.rotation_degrees = current_bullet_rot
	var bullet = preload("res://Scenes/Enemy/Mirror/MirrorBullet.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $ROT/FirePos.global_position
	bullet.global_rotation = $ROT.global_rotation
	current_bullet_rot += 30

func _on_timer_timeout() -> void:
	$Timer.start()
	fire_bullet()


func death():
	queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(area.damage)
