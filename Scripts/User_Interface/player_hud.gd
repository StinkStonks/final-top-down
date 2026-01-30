extends Control
class_name PlayerHUD

@onready var health_progress_bar : ProgressBar = $HealthProgressBar
@onready var ammo_panel_label : Label = $AmmoPanel/AmmoPanelLabel
@onready var interact_label : Label = $InteractLabel

func show_interact_label(interaction : Interactable):
	var txt : String = 'Interact with ' + interaction.interactable_name
	interact_label.visible = true
	interact_label.text = txt 

func hide_interact_label():
	interact_label.visible = false

func update_health_bar(progress : float, max_progress : float) -> void:
	health_progress_bar.value = progress
	health_progress_bar.max_value = max_progress

func update_ammo_label(data : WeaponData):
	var txt = "%s/%s\n%s" % [data.current_ammo, data.max_ammo, data.reserve_ammo]
	ammo_panel_label.text = txt
