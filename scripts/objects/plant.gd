extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sprite_2d.flip_h = randi_range(0,1)


func _on_body_entered(body: Node2D) -> void:
	animation_player.play("shake")
