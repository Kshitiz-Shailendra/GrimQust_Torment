extends Node2D


func _on_area_2d_area_entered(other_area: Area2D) -> void:
	GameEvents.emit_experience_vial_collected(1)
	self.queue_free()
	
