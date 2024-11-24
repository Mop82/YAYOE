extends CharacterBody2D

var bullet_velocity = 1
var damage = 1
var destroy_time = 10

func _ready() -> void:
	$Hitbox.damage = damage
	await get_tree().create_timer(destroy_time).timeout
	velocity = Vector2(bullet_velocity, 0).rotated(rotation)
	queue_free()

func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
