extends Node

class_name State

var parent_state_machine: StateMachine
var character: Character


func init() -> void:
	parent_state_machine = get_parent()


func update(_delta: float) -> void:
	character.update_animation()
	

func update_physics(_delta: float) -> void:
	pass
	
	
func enter() -> void:
	pass
	

func exit() -> void:
	pass
