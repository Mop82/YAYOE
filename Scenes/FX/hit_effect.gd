extends Node2D

func _ready() -> void:
	scale = Vector2(randf_range(1.2, 2), randf_range(1.2, 2))
	$GPUParticles2D2.emitting = true
	$GPUParticles2D3.emitting = true
	await get_tree().create_timer(1).timeout
	queue_free()
