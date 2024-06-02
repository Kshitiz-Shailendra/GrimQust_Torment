extends Node
class_name ExperienceManager


signal experience_updated(current_experience:float, target_experience:float)
signal level_up(new_level:int)

const TARGET_GROWTH:float = 5

var current_experience:float = 0
var current_level:int  = 1
var target_experience:float = 5


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_exp_vial_collected)

func increment_experience(exp: float):
	current_experience = min(current_experience + exp , target_experience)
	experience_updated.emit(current_experience,target_experience)
	
	if current_experience == target_experience:
		target_experience = target_experience + TARGET_GROWTH
		current_level += 1
		current_experience = 0
		experience_updated.emit(current_experience,target_experience)
		level_up.emit(current_level)


func on_exp_vial_collected(number: float):
	increment_experience(number)
