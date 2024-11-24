extends Node2D

func _ready() -> void:
	$GPUParticles2D.emitting = true
	$GPUParticles2D2.emitting = true
	await get_tree().create_timer(11).timeout
	queue_free()
