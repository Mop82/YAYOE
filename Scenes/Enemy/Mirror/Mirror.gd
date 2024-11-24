extends Enemy
class_name Mirror

@export var neuter = false

var jump_time = 0.1
var jump_speed = 35
var can_jump = true

var target_position = Vector2.ZERO

var time = 0.0
var other_time = 0.0

func _ready() -> void:
	target_position = global_position

func _physics_process(delta: float) -> void:
	time += delta
	rotation_degrees = sin(time * 4) * 15
	other_time += delta
	#modulate = Color().from_hsv(1, other_time, 1)
	if other_time > 1:
		other_time = 0.0
	movement(delta)
	move_and_slide()
	

func movement(delta):
	
	velocity = target_position - global_position
	velocity *= jump_speed
	
	if can_jump == false:
		return
	
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("Right"):
		dir = Vector2(-1, 0)
	
	if Input.is_action_pressed("Left"):
		dir = Vector2(1, 0)
	
	if Input.is_action_pressed("Up"):
		dir = Vector2(0, 1)
	
	if Input.is_action_pressed("Down"):
		dir = Vector2(0, -1)
	
	if dir != Vector2.ZERO:
		target_position = global_position + dir * 8
		can_jump = false
		await get_tree().create_timer(jump_time).timeout
		can_jump = true


func _on_timer_timeout() -> void:
	$Timer.start(randf_range(0.25, 1))
	
	if neuter:
		return
	
	var mirror_bullet = preload("res://Scenes/Enemy/Mirror/MirrorBullet.tscn").instantiate()
	get_parent().add_child(mirror_bullet)
	mirror_bullet.global_position = global_position
	mirror_bullet.look_at(player.global_position)
