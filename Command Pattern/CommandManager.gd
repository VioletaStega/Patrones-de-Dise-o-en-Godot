extends Node

var undo_stack : Array[Command] = []
var redo_stack : Array[Command] = []

@onready var player : PlayerMovement = $"../Player"

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		execute_command(MoveCommand.create(player, Vector2(0, -1)))
	if Input.is_action_just_pressed("ui_down"):
		execute_command(MoveCommand.create(player, Vector2(0, 1)))
	if Input.is_action_just_pressed("ui_left"):
		execute_command(MoveCommand.create(player, Vector2(-1, 0)))
	if Input.is_action_just_pressed("ui_right"):
		execute_command(MoveCommand.create(player, Vector2(1, 0)))
	
	#Escalamos con el tab de nuestro teclado
	if Input.is_action_just_pressed("ui_focus_next"):
		execute_command(ScaleCommand.create(player, 0.2))
	
func execute_command (cmd : Command):
	#Ejecutamos el comando
	cmd.execute()
	#Lo añadimos al principio de la matriz y no al final
	undo_stack.push_front(cmd)
	#Limpiamos la pila de redo, porque si hemos hecho un undo,
	#deberíamos de no poder rehacer nada, es decir,
	#cuando te mueves por primera vez el undo se puede usar pero
	#el redo no.
	redo_stack.clear()

func undo_command ():
	#Si el array está vacío pues nos salimos porque no hay nada que deshacer
	if len(undo_stack) == 0:
		return
	#pop_front elimina el elemento del inicio de la pila y lo devuelve
	var cmd = undo_stack.pop_front()
	#Luego queremos agregarlo a la pila de rehacer, así que lo añadimos
	redo_stack.push_front(cmd)
	#Y ya deshacemos el comando.
	cmd.undo()

func redo_command ():
	#Si el array está vacío pues nos salimos porque no hay nada que rehacer
	if len(redo_stack) == 0:
		return
	#pop_front elimina el elemento del inicio de la pila y lo devuelve
	var cmd = redo_stack.pop_front()
	#Luego queremos agregarlo a la pila de deshacer, así que lo añadimos
	undo_stack.push_front(cmd)
	cmd.execute()
