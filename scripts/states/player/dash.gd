extends State

@export var dash_speed_mod: float
@export var dash_acc_mod: float
@export var cooldown: float
@onready var dash_timer: Timer = $"../../DashTimer"
@onready var dash_particles_back: GPUParticles2D = $"../../DashEffects/DashParticlesBack"
@onready var dash_trail: GPUParticles2D = $"../../DashEffects/DashTrail"


const dir_to_trail_frame: Dictionary = {
	"_down": preload("uid://dbjmftx35lxu7"),
	"_left": preload("uid://xu0svb5l0hl7"),
	"_right": preload("uid://xu0svb5l0hl7"),
	"_up": preload("uid://ep7g4l0ac1gk")
}

var action_pressed: bool = false

func enter() -> void:
	super.enter()
	var dir: Vector2 = character.last_direction
	var facing_dir: String = character.get_direction()
	action_pressed = false
	character.direction = dir
	character.speed_mod += dash_speed_mod
	character.acc_mod += dash_acc_mod
	character.current_animation = "dash" + facing_dir
	dash_timer.start()
	
	dash_trail.texture = dir_to_trail_frame[facing_dir]
	dash_trail.emitting = true
	dash_trail.scale.x = -1 if dir.x < 0 else 1
	dash_particles_back.process_material.set("emission_shape_offset", Vector3.ZERO)
	dash_particles_back.process_material.set("gravity", Vector3(-dir.x * 100.0, -dir.y * 100.0, 0.0))
	dash_particles_back.emitting = true
	dash_particles_back.scale.x = -1 if facing_dir == "_left" else 1
	
	var time = dash_timer.wait_time + cooldown
	var tween: Tween = create_tween()
	tween.tween_property(character.body_sprite, "modulate:a", 0.2, time * 0.5)
	tween.tween_property(character.body_sprite, "modulate:a", 1.0, time * 0.5)
	
func update_physics(_delta: float) -> void:
	super.update_physics(_delta)
	if Input.is_action_just_pressed("tool1_action"):
		action_pressed = true


func _on_dash_timer_timeout() -> void:
	character.speed_mod -= dash_speed_mod
	character.acc_mod -= dash_acc_mod
	character.direction = Vector2.ZERO
	var dir: Vector2 = character.last_direction
	dash_particles_back.emitting = false
	if action_pressed:
		parent_state_machine.switch_to("UseSword")
	else:
		await get_tree().create_timer(cooldown).timeout
		if action_pressed:
			parent_state_machine.switch_to("UseSword")
		else:
			parent_state_machine.switch_to("Move")
	dash_trail.emitting = false
	#dash_particles.emitting = false
