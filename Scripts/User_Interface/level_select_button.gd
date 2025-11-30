extends Button
class_name LevelSelectButton

@export var level_data : LevelData = load("res://Resources/Levels/TestRoom1.tres")

signal level_selected(selected_level_data : LevelData)

func _ready() -> void:
	text = level_data.level_name

func _pressed() -> void:
	level_selected.emit(level_data)
