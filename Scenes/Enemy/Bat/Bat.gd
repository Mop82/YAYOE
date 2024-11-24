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

func death():
	queue_free()
