extends Node

@export_range(0,1) var dropPercent: float = 0.5
@export var vialScene: PackedScene
@export var healthComponent: HealthComponent

func _ready() -> void:
	healthComponent.died.connect(on_died)
	
	
func on_died() -> void:
	
	if randf() > dropPercent:
		return
	
	if vialScene == null:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var vialInstance = vialScene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vialInstance)
	vialInstance.global_position = spawn_position 



