extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -400.0
const DOUBLE_JUMP_CD_TIME = 5.0

var can_double_jump := false  
var double_jump_timer := 0.0    

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if double_jump_timer <= 0:
			can_double_jump = true
	
	if double_jump_timer > 0:
		double_jump_timer -= delta

	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif can_double_jump and double_jump_timer <= 0:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false      
			double_jump_timer = DOUBLE_JUMP_CD_TIME 
			print("二段跳已使用！冷卻中...")

	var direction := 0.0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	if left and right:
		if Input.is_action_just_pressed("ui_left"):
			direction = -1.0
		elif Input.is_action_just_pressed("ui_right"):
			direction = 1.0
		else:
			direction = sign(velocity.x)
	else:
		direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
