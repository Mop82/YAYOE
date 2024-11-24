extends Enemy

var bullet_velocity = 10
var damage = 1
var destroy_time = 10

var time = 0.0

func _ready() -> void:
	$hitbox.damage = damage
	await get_tree().create_timer(destroy_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	time += delta
	
	velocity = Vector2(1 * bullet_velocity, 0).rotated(rotation)
	
	look_at(player.global_position)
	
	move_and_slide()
	

func damage_anim():
	var bloodstain = preload("res://Scenes/FX/bloodstain.tscn").instantiate()
	get_parent().get_parent().add_child(bloodstain)
	bloodstain.global_position = global_position
	var scale_ = randf_range(0.2, 0.4)
	bloodstain.scale = Vector2(scale_, scale_)
	$SFX/Hurt.pitch_scale = randf_range(1.5, 2.5)
	$SFX/Hurt.play()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(area.damage)

func death():
	level.normal_enemy_death()
	queue_free()
