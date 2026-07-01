extends CharacterBody2D
class_name Character

var speed: float
var acceleration: float
var last_direction: Vector2
var direction: Vector2
var animation_player: AnimationPlayer
var current_animation: String

func _ready() -> void:
	animation_player = get_node("AnimationPlayer")


func _physics_process(delta: float) -> void:
	last_direction = (direction if direction else last_direction).normalized()
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	move_and_slide()	
	
	
func update_animation() -> void:
	animation_player.play(current_animation)


func get_direction() -> String:
	if last_direction.y >= 0 && last_direction.x >= -0.5 && last_direction.x <= 0.5:
		return "_down"
	elif last_direction.y <= 0 && last_direction.x >= -0.5 && last_direction.x <= 0.5:
		return "_up"
	elif last_direction.x < 0:
		return "_left"
	else:
		return "_right"
