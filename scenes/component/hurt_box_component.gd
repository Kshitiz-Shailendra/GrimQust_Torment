extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitBoxComponent:
		return
	
	if health_component == null:
		return
	
	var hitbox_component = other_area as HitBoxComponent
	health_component.damage(hitbox_component.damage)
