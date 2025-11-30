extends Control
class_name PlayerHUD

@onready var health_progress_bar : ProgressBar = $HealthProgressBar
@onready var AmmoPanelLabel : Label = $AmmoPanel/AmmoPanelLabel

func update_health_bar(progress : float, max_progress : float) -> void:
	health_progress_bar.value = progress
	health_progress_bar.max_value = max_progress

func update_ammo_label(data : WeaponData):
	var txt = "%s/%s\n%s" % [data.current_ammo, data.max_ammo, data.reserve_ammo]
	AmmoPanelLabel.text = txt
