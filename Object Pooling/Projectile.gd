extends Area2D

var speed : float = 300.0

func _process(delta):
	translate(-transform.y * speed * delta)

# Es llamado cuando el timer llegue a su fin
func end_of_lifetime ():
	#Se usaría el queue_free si hubiesemos usado el instantiate
	#queue_free()
	visible = false

func _on_visibility_changed():
	$DestroyTimer.start.call_deferred()
