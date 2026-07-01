extends Character

var player_speed: float = 225.0
var player_acceleration: float = 15.0


func _ready() -> void:
	super._ready()
	speed = player_speed
	acceleration = player_acceleration


func _physics_process(delta: float) -> void: 
	direction = Input.get_vector("left","right","up","down")
	super._physics_process(delta)
