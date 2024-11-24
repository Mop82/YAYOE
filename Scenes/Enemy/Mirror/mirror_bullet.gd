extends CharacterBody2D

var bullet_velocity = 25
var damage = 1
var destroy_time = 10
var time = 0.0

func _ready() -> void:
	$Hitbox.damage = damage
	await get_tree().create_timer(destroy_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	time += delta
	if time > 255:
		time = 0.0
	
	$MirrorBullet.rotation_degrees += 15
	
	velocity = Vector2(1 * bullet_velocity, 0).rotated(rotation)
	
	move_and_slide()
