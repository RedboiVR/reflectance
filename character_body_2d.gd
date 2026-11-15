extends CharacterBody2D
var in_bounce:bool = false

const SPEED = 500.0
const JUMP_VELOCITY = -600.0

var previous_vel_y = 0
var previous_vel_x = 0

var starting_height: float
var bounce_multiplier: float = 1.0

const HEIGHT_SPEED_MULTIPLIER = 0.002

func bounce(direction: Vector2) -> void:
	if in_bounce:
		return

	var height = max(0.0, starting_height - global_position.y)
	bounce_multiplier = 2.0 + height * HEIGHT_SPEED_MULTIPLIER

	var bounce_strength = max(abs(previous_vel_y), abs(JUMP_VELOCITY))

	velocity = direction.normalized() * bounce_strength * bounce_multiplier

	in_bounce = true
	$Timer.start()

func _ready() -> void:
	starting_height = global_position.y

func _physics_process(delta: float) -> void:
	previous_vel_y = velocity.y

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not in_bounce:
		velocity.y = JUMP_VELOCITY

	# Movement
	if not in_bounce:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x = direction * SPEED

	move_and_slide()


func _on_timer_timeout() -> void:
	in_bounce = false
