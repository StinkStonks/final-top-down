extends Node2D
class_name HungerComponent

@onready var timer : Timer = $Timer
@export var max_hunger : float = 100
@export var hunger_tick_rate : float = 1
@export var hunger_tick_amount : float = 1
var current_hunger : float : 
	get: 
		return current_hunger
	set(value):
		current_hunger = clampf(value, 0, max_hunger)

signal starve(amount : float)
signal hunger_amount_changed(amount, max_amount)
 
func _ready() -> void:
	current_hunger = max_hunger
	timer.connect('timeout', tick_hunger)
	timer.start(hunger_tick_rate)

func tick_hunger():
	current_hunger -= hunger_tick_amount
	
	if current_hunger <= 0:
		starve.emit(hunger_tick_amount)
	
	hunger_amount_changed.emit(current_hunger, max_hunger)

func eat_food(amount : float):
	current_hunger += amount
	hunger_amount_changed.emit(current_hunger, max_hunger)
