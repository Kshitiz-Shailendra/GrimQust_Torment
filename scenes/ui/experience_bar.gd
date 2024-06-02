extends CanvasLayer

@export var experience_manager: ExperienceManager

@onready var progress_bar = $MarginContainer/ProgressBar

func _ready() -> void:
	experience_manager.experience_updated.connect(on_exp_updated)


func on_exp_updated(current_exp:float, target_exp:float):
	var calc_value:float = current_exp / target_exp
	progress_bar.value = calc_value
