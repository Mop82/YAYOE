extends CharacterBody2D

var jump_time = 0.1
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

var health = 10
var heat = 0
var heat_overload = false

var time = 0.0

var rifle_shoot = false

func _ready() -> void:
	target_position = global_position

func _physics_process(delta: float) -> void:
	$Health.value = health
	$heat.value = heat
	
	time += delta
	
	$Icon.rotation_degrees = sin(time * 2) * 10
	movement(delta)
	mouse_movement(delta)
	move_and_slide()
	
	if can_shoot and $heatdown.is_stopped():
		$heatdown.start()
	
	if !can_shoot:
		$heatdown.stop()
	
	if heat > 100:
		heat = 100
	
	if heat < 0:
		heat = 0
	
	if heat == 100:
		heat_overload = true
	if heat_overload:
		if heat == 0:
			heat_overload =false
	
	if Input.is_action_pressed("LeftClick") and rifle_shoot == false and heat_overload == false:
		rifle_shoot = true
		await get_tree().create_timer(0.15).timeout
		if Input.is_action_pressed("LeftClick"):
			rifle()
		else:
			shotgun()
	else:
		rifle_shoot = false
	

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
	if get_global_mouse_position().x > global_position.x:
		$Icon.flip_h = true
		$Gun/Gun.flip_v = false
	else:
		$Icon.flip_h = false
		$Gun/Gun.flip_v = true

func shoot():
	if can_shoot == false or heat_overload == true:
		return
	
	can_shoot = false
	
	for i in bullets_shot:
		var bullet = preload("res://Scenes/Player/Bullet/Bullet.tscn").instantiate()
		
		bullet.global_position = gun_tip.global_position
		bullet.global_rotation = gun_tip.global_rotation
		bullet.rotation_degrees += randf_range(-spread, spread)
		bullet.bullet_velocity = bullet_velocity + randf_range(-15, 15)
		bullet.damage = damage_per_bullet
		bullet.destroy_time = destroy_time
		
		get_parent().add_child(bullet)
	
	await get_tree().create_timer(shoot_cooldown).timeout
	
	can_shoot = true


func rifle():
	
	shoot_cooldown = 0.15
	bullets_shot = 1
	damage_per_bullet = 1
	spread = 10
	bullet_velocity = 200
	destroy_time = 10
	
	heat += 0.5
	
	shoot()

func shotgun():
	
	shoot_cooldown = 0.5
	bullets_shot = 5
	damage_per_bullet = 1
	spread = 15
	bullet_velocity = 150
	destroy_time = 10
	
	heat += 2
	
	shoot()
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(area.damage)

func take_damage(damage):
	health -= damage

func _on_heatdown_timeout() -> void:
	heat -= 5
