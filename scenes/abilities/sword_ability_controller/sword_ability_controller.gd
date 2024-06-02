extends Node

@export var MAX_RANGE:float = 150
@export var sword_ability:PackedScene

var damage:float = 5
var default_wait_time:float
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	default_wait_time = $Timer.wait_time
	GameEvents.ability_upgrade_applied.connect(on_ability_upgrade_applied)

func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	#print(enemies.size())
	#print("\n")
	enemies = enemies.filter(func(enemy:Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE,2)
	)
	#print(enemies.size())
	
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b:Node2D):
		return (b.global_position.distance_squared_to(player.global_position) 
				> a.global_position.distance_squared_to(player.global_position))  
	)
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	#This is done to randomize the spawning of sword within a limit
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0,TAU)) * 4
	sword_instance.hitbox_component.damage = damage
	var enemy_direction:Vector2 = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
	

func on_ability_upgrade_applied(upgrade:AbilityUpgrade, current_upgrades:Dictionary):
	if upgrade.id != "sword_rate":
		return
	
	var percent_reduction = current_upgrades[upgrade.id]["quantity"] *.1
	$Timer.wait_time = default_wait_time - (1-percent_reduction)
	$Timer.start()
	print($Timer.wait_time)	
