extends Node

const MAINMENUPATH = "res://Levels/main_menu.tscn"

func restart_level() -> void:
	get_tree().reload_current_scene()
	pause_game(false)

func load_level(data : LevelData) -> void:
	get_tree().change_scene_to_packed(data.level_scene)
	pause_game(false)

func return_to_menu() -> void:
	get_tree().change_scene_to_file(MAINMENUPATH)
	pause_game(false)

func pause_game( paused : bool = true, invert : bool = false) -> void:
	if invert:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = paused

func quit_game() -> void:
	get_tree().quit()
