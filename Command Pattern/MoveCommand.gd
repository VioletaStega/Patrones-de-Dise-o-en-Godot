extends Command
class_name MoveCommand

var player_movement : PlayerMovement
var move_dir : Vector2

#Hacemos esta función para no tener que especificar
#cuatro veces diferentes el comando de movimiento
#Esto va a ser como una especie de pseudoconstructor
#El static nos permite llamar a esta función aunque no haya una instancia
#creada
static func create (pm : PlayerMovement, dir : Vector2) -> MoveCommand:
	var i = MoveCommand.new()
	i.player_movement = pm
	i.move_dir = dir
	return i

#Tenemos que crear estas dos funciones porque extendemos de Command
#Command es como si fuese una interfaz
func execute ():
	#Llamamos a la función move del script PlayerMovement
	player_movement.move(move_dir)

func undo ():
	player_movement.move(-move_dir)
