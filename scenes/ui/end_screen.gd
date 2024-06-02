extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
func set_defeat() -> void:
	%TitleLabel.text = "Defeat"
	%DescriptionLabel.text = "You Lost!"

func on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_button_pressed() -> void:
	get_tree().quit()
