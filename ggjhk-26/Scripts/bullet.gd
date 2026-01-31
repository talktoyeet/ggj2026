extends Area2D

const speed = 100
var lifetime = 10
@onready var timer: Timer = $Timer

enum BulletType { SMALL, BIG, LASER }

func _setup_bullet(type: BulletType):
	var atlas = $Sprite2D.texture as AtlasTexture
	match type:
		BulletType.SMALL:
			atlas.region = Rect2(0, 0, 8, 8)
		BulletType.BIG:
			atlas.region = Rect2(8, 0, 12, 12)
		BulletType.LASER:
			atlas.region = Rect2(0, 8, 24, 6)

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
