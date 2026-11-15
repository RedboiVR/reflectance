extends Sprite2D

const splat = preload("res://splat.tscn")
const ball = preload("res://ball.tscn")

func place_splat(rot:float, pos:Vector2) -> void:
	var splat = splat.instantiate()
	splat.global_position = pos
	splat.global_rotation = rot
	get_tree().root.add_child(splat)

func shoot_ball() -> void:
	var new_ball = ball.instantiate()
	var direction = Vector2.from_angle(global_rotation + PI)

	new_ball.visible = true

	new_ball.direction = direction
	new_ball.rotation = global_rotation
	get_tree().root.add_child(new_ball)

	new_ball.global_position = global_position + direction * 120.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot_ball()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	rotation = (global_position.direction_to(mouse_pos).angle() + PI)
