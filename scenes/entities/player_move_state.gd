extends State

var walk_cutoff: float = 0.05
var run_cutoff: float = 0.5

func update() -> void:
	super.update()
	character.current_animation = get_movement_type() + character.get_direction()

func get_movement_type() -> String:
	if character.velocity.length() > character.speed * run_cutoff:
		return "run"
	elif character.velocity.length() > character.speed * walk_cutoff:
		return "walk"
	else:
		return "idle"
