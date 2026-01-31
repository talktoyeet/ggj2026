extends Node2D

const speed = 100
var lifetime = 10

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
