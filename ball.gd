extends Area2D

const splat = preload("res://splat.tscn")

var direction: Vector2
var speed := 1500.0

func _physics_process(delta: float) -> void:
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + direction * speed * delta
	)

	var result = get_world_2d().direct_space_state.intersect_ray(query)

	if result:
		var splat_normal: Vector2 = result.normal

		var new_splat = splat.instantiate()
		get_tree().root.add_child(new_splat)

		new_splat.global_position = result.position
		new_splat.global_rotation = splat_normal.angle() + PI / 2.0

		queue_free()
		return

	global_position += direction * speed * delta

func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D: return
	if body is Area2D: return
	print("PAINTBALL HIT: ", body.name)

	var new_splat = splat.instantiate()

	get_tree().root.add_child(new_splat)

	new_splat.global_position = global_position
	new_splat.global_rotation = global_rotation + PI

	print("SPLAT CREATED: ", new_splat.global_position)

	queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
