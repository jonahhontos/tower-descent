extends Character
class_name Player

var player_speed: float = 225.0
var player_acceleration: float = 15.0

var tool_1_action: Global.Tools = Global.Tools.SWORD


func _ready() -> void:
	super._ready()
	speed = player_speed
	acceleration = player_acceleration
