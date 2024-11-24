extends CharacterBody2D

var bullet_velocity = 1
var damage = 1
var destroy_time = 10

var hit_tally = 1

func _ready() -> void:
	$Hitbox.damage = damage
	await get_tree().create_timer(destroy_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	velocity = Vector2(bullet_velocity, 0).rotated(rotation)
	var collision_object = move_and_collide(velocity * delta)
	if collision_object:
		if hit_tally == 1:
			var hit = preload("res://Scenes/FX/HitEffect.tscn").instantiate()
			hit.global_position = global_position
			get_parent().add_child(hit)
			queue_free()
		hit_tally = 1
		var angles = [180, 170, 190]
		rotation_degrees += angles.pick_random()
