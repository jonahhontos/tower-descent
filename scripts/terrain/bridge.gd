extends StaticBody2D


func _on_disable_water_collsion_body_entered(body: Node2D) -> void:
	body.set_collision_mask_value(1, false)


func _on_disable_water_collsion_body_exited(body: Node2D) -> void:
	body.set_collision_mask_value(1, true)
