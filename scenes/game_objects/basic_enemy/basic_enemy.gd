extends CharacterBody2D

const MAX_SPEED = 40

@onready var health_component:HealthComponent = $HealthComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_direction_to_player()
	self.velocity = direction * MAX_SPEED
	self.move_and_slide()

func get_direction_to_player() -> Vector2:
	var player_nodes = get_tree().get_first_node_in_group("player") as Node2D
	if player_nodes != null:
		return (player_nodes.global_position - self.global_position).normalized()
	return Vector2.ZERO


