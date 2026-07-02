extends Character

var player_speed: float = 225.0
var player_acceleration: float = 15.0


func _ready() -> void:
	super._ready()
	speed = player_speed
	acceleration = player_acceleration
