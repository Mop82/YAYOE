extends Enemy
class_name Bat

var time = 0.0

func _physics_process(delta: float) -> void:
	time += delta
	rotation_degrees = sin(time) * 5
	velocity = player.global_position - global_position
	velocity = velocity.normalized() * speed
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	take_damage(area.damage)

func damage_anim():
	var bloodstain = preload("res://Scenes/FX/bloodstain.tscn").instantiate()
	get_parent().get_parent().add_child(bloodstain)
	bloodstain.global_position = global_position
	var scale_ = randf_range(0.6, 1)
	bloodstain.scale = Vector2(scale_, scale_)
	$SFX/Hurt.pitch_scale = randf_range(1.5, 2.5)
	$SFX/Hurt.play()

func death():
	queue_free()
