extends Node
class_name StateMachine

var current_state: State
var animations: AnimationPlayer

func _ready() -> void:
	for child in get_children():
		var child_state: State = child as State
		child_state.character = get_parent()
		child_state.init()
	
	current_state = get_child(0)
	current_state.enter()


func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)


func _process(_delta: float) -> void:
	current_state.update(_delta)
	
	
func switch_to(name: String) -> void:
	var state: State = get_node(name)
	
	if !state:
		print("could not find state ", name)
		
	current_state.exit()
	current_state = state
	current_state.enter()
