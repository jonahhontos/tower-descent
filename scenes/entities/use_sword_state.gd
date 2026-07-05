extends State

var combo_step: int = 0
var next_step: int = 0
var can_act: bool = false
var state_active: bool = false

const MAX_COMBO: int = 3


func enter() -> void:
	super.enter()
	play_next_animation()
	state_active = true
	

func exit() -> void:
	super.exit()
	state_active = false
	combo_step = 0
	next_step = 0


func update_physics(_delta: float) -> void:
	var combo_plus_one: int = posmod(combo_step + 1, MAX_COMBO)
	# !! TODO !! make this action dynamic
	if Input.is_action_just_pressed("tool1_action"):
		next_step = combo_plus_one
	
	if can_act:
		if next_step == combo_plus_one:
			combo_step = next_step
			play_next_animation()
		elif Input.get_vector("left","right","up","down"):
			print("movin'")
			parent_state_machine.switch_to("Move")


func play_next_animation() -> void:
	character.current_animation = "sword_" + str(combo_step) + character.get_direction()
	can_act = false
	print("setting can act false")


func enable_actions() -> void:
	print("setting can act true")
	can_act = true


func end_attack() -> void:
	parent_state_machine.switch_to("Move")
