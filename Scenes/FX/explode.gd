extends Node2D

func _ready() -> void:
	$GPUParticles2D3.emitting = true
	$GPUParticles2D4.emitting = true
	$GPUParticles2D5.emitting = true
	$GPUParticles2D6.emitting = true
	await get_tree().create_timer(2).timeout
	queue_free()
