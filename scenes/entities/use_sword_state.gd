extends State

@export var movement_drift: int

var combo_step: int = 0
var next_step: int = 0
var can_act: bool = false
var can_move: bool = false

const MAX_COMBO: int = 2


func enter() -> void:
	super.enter()
	play_next_animation()
	

func exit() -> void:
	super.exit()
	combo_step = 0
	next_step = 0


func update_physics(_delta: float) -> void:
	super.update_physics(_delta)
	var combo_plus_one: int = combo_step + 1
	# !! TODO !! make this action dynamic
	if Input.is_action_just_pressed("tool1_action"):
		next_step = clampi(combo_plus_one, 0, MAX_COMBO)
	
	var input: Vector2 = Input.get_vector("left","right","up","down")
	
	if can_act:
		if next_step == combo_plus_one:
			combo_step = next_step
			if input:
				character.last_direction = input
				character.velocity += input * movement_drift
			play_next_animation()
		elif can_move && input:
			parent_state_machine.switch_to("Move")


func play_next_animation() -> void:
	character.current_animation = "sword_" + str(combo_step) + character.get_direction()
	can_act = false
	can_move = false


func enable_actions() -> void:
	can_act = true


func enable_movement() -> void:
	can_move = true
	

func end_attack() -> void:
	parent_state_machine.switch_to("Move")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if parent_state_machine.current_state == self:
		end_attack()
