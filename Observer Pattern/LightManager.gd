extends Node

signal turn_on_lights
signal turn_off_lights

func _process(delta):
	#Emitimos la señal encender las luces al pulsar la tecla hacia arriba
	if Input.is_action_just_pressed("ui_up"):
		turn_on_lights.emit()
	
	#Emitimos la señal apagar las luces al pulsar la tecla hacia abajo
	if Input.is_action_just_pressed("ui_down"):
		turn_off_lights.emit()

"""
ESTA SERÍA LA FORMA NO RECOMENDABLE DE HACERLO:

@onready var light_1 = $"../OmniLight3D"
@onready var light_2 = $"../OmniLight3D2"
@onready var light_3 = $"../OmniLight3D3"
@onready var light_4 = $"../OmniLight3D4"
@onready var light_5 = $"../OmniLight3D5"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		light_1.light_energy = 1
		light_2.light_energy = 1
		light_3.light_energy = 1
		light_4.light_energy = 1
		light_5.light_energy = 1
	if Input.is_action_just_pressed("ui_down"):
		light_1.light_energy = 0
		light_2.light_energy = 0
		light_3.light_energy = 0
		light_4.light_energy = 0
		light_5.light_energy = 0
"""
