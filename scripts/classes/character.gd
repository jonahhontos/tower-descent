extends CharacterBody2D
class_name Character

@export var speed: float
@export var acceleration: float
var speed_mod: float = 1.0
var acc_mod: float = 1.0
var last_direction: Vector2
var direction: Vector2
var animation_player: AnimationPlayer
var current_animation: String
var previous_animation: String

func _ready() -> void:
	animation_player = get_node("AnimationPlayer")


func _physics_process(delta: float) -> void:
	last_direction = (direction if direction else last_direction).normalized()
	velocity = velocity.lerp(direction * (speed * speed_mod), (acceleration * acc_mod) * delta)
	move_and_slide()	
	
	
func update_animation() -> void:
	if current_animation != previous_animation:
		animation_player.play(current_animation)
		previous_animation = current_animation


func get_direction() -> String:
	if last_direction.y >= 0 && last_direction.x >= -0.5 && last_direction.x <= 0.5:
		return "_down"
	elif last_direction.y <= 0 && last_direction.x >= -0.5 && last_direction.x <= 0.5:
		return "_up"
	elif last_direction.x < 0:
		return "_left"
	else:
		return "_right"
