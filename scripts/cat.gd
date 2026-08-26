extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _ready() -> void:
	# Создаем новые действия для A и D
	InputMap.add_action("move_left")
	var ev_left = InputEventKey.new()
	ev_left.keycode = KEY_A
	InputMap.action_add_event("move_left", ev_left)

	InputMap.add_action("move_right")
	var ev_right = InputEventKey.new()
	ev_right.keycode = KEY_D
	InputMap.action_add_event("move_right", ev_right)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
