extends Camera2D
## Cámara principal para escenarios.
##
## Mueve la cámara para seguir al personaje principal (usando un movimiento suavizado)
## Movimiento de cámara: https://docs.google.com/document/d/1kHbZN0nhy9GFL3zyO4tTZK4lqELZ3YDkbpxj6XVEkq8/edit?usp=sharing


# Referencia al personaje principal
@export var character: Area2D


# Función de inicialización
func _ready():
	# Si no hay personaje, deshabilitamos _physics_process y terminamos la función
	if not character:
		set_physics_process(false)
		return
	# Seteamos posición inicial de la cámara
	position = character.position


# Función de ejecución de físicas
func _physics_process(delta):
	# Generamos posiciones "interpoladas" (entre la posición de la cámara y el personaje)
	# para realizar el movimiento de la cámara
	# Validamos si el personaje esta vivo y no murio
	if  character:
		# Si el personaje esta muerto dejamos de seguirlo
		return
	var previousx=position.x
	var charpos = character.position
	var INITIAL_POS = position.lerp(charpos, delta * 2.0)
	# Ajustamos los valores a números enteros, para evitar mover la cámara demasiadas veces
	INITIAL_POS.x = int(INITIAL_POS.x)
	INITIAL_POS.y = int(INITIAL_POS.y)
	# Seteamos la nueva posición de la cámara
	position = INITIAL_POS
	position.x=previousx
