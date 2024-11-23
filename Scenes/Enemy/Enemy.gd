extends CharacterBody2D
class_name Enemy

@export var health = 1
@export var speed = 10.0

@onready var player = get_tree().get_first_node_in_group("Player")

func take_damage(damage):
	health -= damage
	
	damage_anim()
	
	if health <= 0:
		death()

func death():
	pass

func damage_anim():
	pass
