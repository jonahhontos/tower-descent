extends State

var walk_cutoff: float = 0.1
var run_cutoff: float = 0.5

var player: Player

func init() -> void:
	super.init()
	player = character


func update_physics(_delta: float) -> void:
	super.update_physics(_delta)
	player.direction = Input.get_vector("left","right","up","down")
	
	if Input.is_action_just_pressed("tool1_action"):
		parent_state_machine.switch_to("Use" + Global.ToolMap[player.tool_1_action])


func update(_delta: float) -> void:
	super.update(_delta)
	player.current_animation = get_movement_type() + player.get_direction()

func get_movement_type() -> String:
	if player.velocity.length() > player.speed * run_cutoff:
		return "run"
	elif player.velocity.length() > player.speed * walk_cutoff:
		return "walk"
	else:
		return "idle"
		

func exit() -> void:
	super.exit()
	player.direction = Vector2.ZERO
