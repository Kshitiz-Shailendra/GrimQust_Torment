extends CanvasLayer

signal upgrade_selected(upgrade:AbilityUpgrade)

@export var ability_upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer

func _ready() -> void:
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var ability_card_instance = ability_upgrade_card_scene.instantiate() as AbilityCardUpgrade
		ability_card_instance.set_ability_upgrade(upgrade)
		card_container.add_child(ability_card_instance)
		ability_card_instance.upgrade_card_selected.connect(on_ability_card_selected.bind(upgrade))
		
		
func on_ability_card_selected(upgrade:AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	self.queue_free()
