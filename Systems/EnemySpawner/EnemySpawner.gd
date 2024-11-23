@tool
extends Marker2D
class_name EnemySpawner

@export var spawn_item : PackedScene

enum types {enemy, trap, boss}

@export var type : types
@export var update = false

var time = 0.0
var speed = randf_range(0.5, 1.5)

func _process(delta: float) -> void:
	time += delta
	if update:
		update = false
		update_icon()
	$Enemy.rotation_degrees = sin(time * speed) * 15
	$Boss.rotation_degrees = sin(time * speed) * 15

func update_icon():
	if type == types.trap:
		$Trap.show()
		$Enemy.hide()
		$Boss.hide()
	if type == types.enemy:
		$Trap.hide()
		$Enemy.show()
		$Boss.hide()
	if type == types.boss:
		$Trap.hide()
		$Enemy.hide()
		$Boss.show()

func spawn():
	var item = spawn_item.instantiate()
	item.global_position = global_position
	get_parent().add_child(item)
	queue_free()
