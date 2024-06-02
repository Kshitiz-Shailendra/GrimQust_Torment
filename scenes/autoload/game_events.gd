extends Node

signal experience_vial_collected(number: float)
signal ability_upgrade_applied

func emit_experience_vial_collected(number: float) -> void:
	experience_vial_collected.emit(number)

func emit_ability_upgrade_applied(upgrade:AbilityUpgrade, current_upgrades:Dictionary):
	ability_upgrade_applied.emit(upgrade,current_upgrades)
