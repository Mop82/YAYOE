extends Enemy
class_name Dasher

var is_dashing = false

func _ready() -> void:
	$Timer.start(randf_range(3, 5))

func _physics_process(delta: float) -> void:
	move_and_slide()
	look_at(global_position + velocity.normalized())
	if is_dashing == true:
		return
	velocity = player.global_position - global_position
	velocity = velocity.normalized() * speed
	
	if global_position.x < global_position.x + velocity.normalized().x:
		$Icon.flip_v = false
	else:
		$Icon.flip_v = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	take_damage(area.damage)

var dash_mult = 15
var dash_duration = 2

func _dash():
	is_dashing = true 
	var player_pos = player.global_position - global_position
	velocity = player.global_position - global_position
	velocity = velocity.normalized() * speed * dash_mult
	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false 

func death():
	queue_free()

func _on_timer_timeout() -> void:
	_dash()
	$Timer.start(randf_range(3, 5))
