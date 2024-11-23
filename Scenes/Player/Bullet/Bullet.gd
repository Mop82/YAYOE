extends CharacterBody2D

var bullet_velocity = 1
var damage = 1
var destroy_time = 10

func _ready() -> void:
	$Hitbox.damage = damage
	await get_tree().create_timer(destroy_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	velocity = Vector2(1 * bullet_velocity, 0).rotated(rotation)
	
	move_and_slide()
