extends PanelContainer
class_name AbilityCardUpgrade

signal upgrade_card_selected

@onready var name_label:Label = $%NameLabel
@onready var desc_label:Label = $%DescLabel

func set_ability_upgrade(upgrade:AbilityUpgrade):
	await self.ready
	name_label.text = upgrade.name
	desc_label.text = upgrade.description
	


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		upgrade_card_selected.emit()
