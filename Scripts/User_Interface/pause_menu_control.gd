extends Control
class_name PauseMenuControl

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()

func pause_game() -> void:
	GameManager.pause_game(true, true)
	visible = get_tree().paused

func restart_level() -> void:
	GameManager.restart_level()

func return_to_menu() -> void:
	GameManager.return_to_menu()

func quit_game() -> void:
	GameManager.quit_game()
