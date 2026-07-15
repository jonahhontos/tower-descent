extends State

@export var dash_speed_mod: float
@export var dash_acc_mod: float
@export var cooldown: float
@onready var dash_timer: Timer = $"../../DashTimer"
@onready var dash_particles: GPUParticles2D = $"../../DashParticles"
var action_pressed: bool = false

func enter() -> void:
	super.enter()
	var dir: Vector2 = character.last_direction
	action_pressed = false
	character.direction = dir
	character.speed_mod += dash_speed_mod
	character.acc_mod += dash_acc_mod
	character.current_animation = "dash" + character.get_direction()
	dash_timer.start()
	
	dash_particles.process_material.set("gravity", Vector3(-dir.x * 100.0, -dir.y * 100.0, 0.0))
	dash_particles.emitting = true
	dash_particles.scale.x = -1 if dir.x < 0 else 1
	var tween: Tween = create_tween()
	tween.tween_property(character.body_sprite, "modulate:a",0.4, dash_timer.wait_time * 0.1)
	tween.tween_interval(dash_timer.wait_time * 0.6)
	tween.tween_property(character.body_sprite, "modulate:a",1.0, dash_timer.wait_time * 0.3)
	
func update_physics(_delta: float) -> void:
	super.update_physics(_delta)
	if Input.is_action_just_pressed("tool1_action"):
		action_pressed = true


func _on_dash_timer_timeout() -> void:
	dash_particles.emitting = false
	character.speed_mod -= 1.0
	character.acc_mod -= 1.0
	character.direction = Vector2.ZERO
	if action_pressed:
		parent_state_machine.switch_to("UseSword")
	else:
		await get_tree().create_timer(cooldown).timeout
		parent_state_machine.switch_to("Move")
