extends CharacterBody3D

const SPEED: float = 30.0
const JUMP_HEIGHT: float = 20.0

var coins : int = 0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2.1
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += JUMP_HEIGHT
	
	position.z = clamp(position.z, 0.0, 0.0)
	velocity.x = SPEED * direction
	
	move_and_slide()
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	$"../coin".queue_free()
	coins += 1
	$UI/coins.text = str(coins)
