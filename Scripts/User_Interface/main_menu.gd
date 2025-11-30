extends CanvasLayer
class_name MainMenu

@onready var menu_dict = {
	0 : $Control/MainMenuPanel,
	1 : $Control/CampaignSelectionPanel,
	2 : $Control/ArenaSelectionPanel
}

var focused_menu : Control

signal focused_menu_switched(new_menu : Control)

func _ready() -> void:
	focused_menu = menu_dict[0]
	focused_menu.visible = true

func switch_focused_menu(menu_idx : int):
	focused_menu.visible = false
	focused_menu = menu_dict[menu_idx]
	focused_menu.visible = true
	focused_menu_switched.emit(focused_menu)

func call_quit_game():
	GameManager.quit_game()
