extends CharacterBody2D

@export var move_speed : float = 50.0
@export var fire_rate : float = 0.05
var last_fire_time : float

@onready var sprite : Sprite2D = get_node("Sprite")
#Este onready lo usaríamos si instanciasemos las balas
#@onready var projectile_scene = preload("res://Object Pooling/Projectile.tscn")
@onready var projectile_pool = $ObjectPool_Projectile

func _physics_process(delta):
	# Movimiento del player
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * move_speed
	
	# Giramos el sprite en función del movimiento
	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true
	
	move_and_slide()

func _process(delta):
	# Disparamos con el botón izquierdo del ratón
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_try_fire_projectile() 

#Programamos el lanzamiento de espadas
func _try_fire_projectile ():
	# Nos salimos si intentamos volver a disparar demasiado rápido
	if Time.get_unix_time_from_system() - last_fire_time < fire_rate:
		return
	
	last_fire_time = Time.get_unix_time_from_system()
	
	# calculate mouse direction from player
	var mouse_dir = position.direction_to(get_global_mouse_position())
	
	# Código si lo hiciesemos con el instantiate
	#var proj = projectile_scene.instantiate()
	#get_tree().get_root().add_child(proj)
	
	var proj = projectile_pool.spawn()
	
	# Modificamos la posición y rotación
	proj.global_position = global_position
	proj.rotation = mouse_dir.angle() + deg_to_rad(90 + randf_range(-5, 5))
