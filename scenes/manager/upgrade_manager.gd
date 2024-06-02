extends Node
class_name UpgradeManager

@export var upgrade_pool:Array[AbilityUpgrade]
@export var experience_manager:ExperienceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)
	


func on_level_up(new_level:int) -> void:
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	self.add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

func on_upgrade_selected(chosen_upgrade:AbilityUpgrade):
	apply_upgrade(chosen_upgrade)

func apply_upgrade(chosen_upgrade:AbilityUpgrade):
	print("chosen upgrade"+chosen_upgrade.id)
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	print("has_upgrade "+str(has_upgrade))
	if !has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource" : chosen_upgrade,
			"quantity" : 1
		}
	else:
		print(chosen_upgrade.id)
		current_upgrades[chosen_upgrade.id]["quantity"] +=1
	GameEvents.emit_ability_upgrade_applied(chosen_upgrade,current_upgrades)	
	print(current_upgrades)
