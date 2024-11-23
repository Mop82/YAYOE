extends Enemy
class_name Mirror


var jump_time = 0.2
var jump_speed = 35
var can_jump = true

var target_position = Vector2.ZERO

func _ready() -> void:
	target_position = global_position

func _physics_process(delta: float) -> void:
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
