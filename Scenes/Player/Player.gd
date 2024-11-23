extends CharacterBody2D

var jump_time = 0.2
var jump_speed = 35
var can_jump = true

var target_position = Vector2.ZERO

var shoot_cooldown = 0.2
var bullets_shot = 1
var damage_per_bullet = 1
var spread = 15
var bullet_velocity = 200
var destroy_time = 10
var can_shoot = true

@onready var gun = $Gun
@onready var gun_tip = $Gun/GunTip

func _ready() -> void:
	target_position = global_position

func _physics_process(delta: float) -> void:
	movement(delta)
	mouse_movement(delta)
	move_and_slide()
	
	if Input.is_action_pressed("LeftClick"):
		shoot()

func movement(delta):
	
	velocity = target_position - global_position
	velocity *= jump_speed
	
	if can_jump == false:
		return
	
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("Right"):
		dir = Vector2(1, 0)
	
	if Input.is_action_pressed("Left"):
		dir = Vector2(-1, 0)
	
	if Input.is_action_pressed("Up"):
		dir = Vector2(0, -1)
	
	if Input.is_action_pressed("Down"):
		dir = Vector2(0, 1)
	
	if dir != Vector2.ZERO:
		target_position = global_position + dir * 8
		can_jump = false
		await get_tree().create_timer(jump_time).timeout
		can_jump = true

func mouse_movement(delta):
	$Gun.look_at(get_global_mouse_position())

func shoot():
	if can_shoot == false:
		return
	
	can_shoot = false
	
	for i in bullets_shot:
		var bullet = preload("res://Scenes/Player/Bullet/Bullet.tscn").instantiate()
		
		bullet.global_position = gun_tip.global_position
		bullet.global_rotation = gun_tip.global_rotation
		bullet.rotation_degrees += randf_range(-spread, spread)
		bullet.bullet_velocity = bullet_velocity + randf_range(-2, 2)
		bullet.damage = damage_per_bullet
		bullet.destroy_time = destroy_time
		
		get_parent().add_child(bullet)
	
	await get_tree().create_timer(shoot_cooldown).timeout
	
	can_shoot = true
