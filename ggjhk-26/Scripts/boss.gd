extends Node2D

const BULLET_SCENE: PackedScene = preload("res://Scenes/Bullet.tscn")

@onready var shoot_timer: Timer = $ShootTimer
@onready var rotator: Node2D = $Rotator

const ROTATE_SPEED: float = 0
const SHOOTER_TIMER_WAIT_TIME: float = 0.2
const SPAWN_POINT_COUNT: int = 4
const RADIUS: float = 10

func _ready() -> void:
	# create spawn points in a circle
	print("ready")
	var step := TAU / float(SPAWN_POINT_COUNT)  # TAU = 2 * PI in Godot 4
	for i in SPAWN_POINT_COUNT:
		var spawn_point := Node2D.new()
		var pos := Vector2(RADIUS, 0.0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

	shoot_timer.wait_time = SHOOTER_TIMER_WAIT_TIME
	shoot_timer.timeout.connect(_on_ShootTimer_timeout)
	print("starting timer")
	shoot_timer.start()


func _process(delta: float) -> void:
	var new_rotation := rotator.rotation_degrees + ROTATE_SPEED * delta
	rotator.rotation_degrees = fmod(new_rotation, 360.0)


func _on_ShootTimer_timeout() -> void:
	for s in rotator.get_children():
		var bullet := BULLET_SCENE.instantiate()
		# better to add to a game/arena node instead of root, but this works:
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = s.global_position
		bullet.global_rotation = s.global_rotation
