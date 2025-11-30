extends Panel
class_name CampaignSelectionScript

@onready var level_name_label : Label = $LevelDetailPanel/LevelNameHeaderPanel/LevelNameHeaderPanel/LevelName
@onready var level_description_label : Label = $LevelDetailPanel/LevelDescriptionPanel/LevelDescriptionLabel
@onready var level_preview_texture_rect : TextureRect = $LevelDetailPanel/LevelPreviewTexutreRect

var focused_level_data : LevelData = null

func change_focused_level(level_data : LevelData) -> void:
	focused_level_data = level_data
	
	level_name_label.text = focused_level_data.level_name
	level_description_label.text = focused_level_data.level_description
	level_preview_texture_rect.texture = focused_level_data.level_preview_texture

func load_focused_level() -> void:
	GameManager.load_level(focused_level_data)
