extends Node

@export var scene_to_spawn : PackedScene
#Crea un numero inicial de instancias y de ahí va tirando
@export var initial_amount : int

var pool : Array = []

func _ready():
	#Nada más arrancar el juego, generaremos una cantidad inicial de espadas
	for i in range(initial_amount):
		print("Nodo inicial")
		_create_new_node()

#Función que creará un número de espadas determinadas, durante el ready
func _create_new_node ():
	var node = scene_to_spawn.instantiate()
	#El Call_deferred retrasa cualquier llamada de función anterior
	#retrasandolo hasta el final del fotograma anterior
	#Aquí estaríamos intentando añadir los hijos antes de que la jerarquía
	#este lista para ser usada
	get_tree().get_root().add_child.call_deferred(node)
	node.visible = false
	pool.append(node)
	return node

#Busca un nodo que no esté en uso y lo devuelve
#El nodo disponible será aquel que no esté visible
func spawn ():
	var node = null
	
	for i in len(pool):
		if pool[i].visible == false:
			node = pool[i]
			#Este break es para evitar que el bucle siga ejecutandose
			#después de haber encontrado un nodo no visible
			break
	
	#Si no hay espadas disponibles y seguimos indicando que queremos disparar
	#creamos un nodo nuevo
	if node == null:
		print("Nodo nuevo")
		node = _create_new_node()
	
	#Como hemos encontrado un nodo no visible pues lo activamos
	node.visible = true
	return node
