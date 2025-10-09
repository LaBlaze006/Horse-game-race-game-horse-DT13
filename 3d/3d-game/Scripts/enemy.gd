extends CharacterBody3D


var speed: float = 25.0
var direction: int = 1
@export var raycast: Node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = speed * direction
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is StaticBody3D:
			_change_direction()
	
	move_and_slide()


func _change_direction() -> void:
	direction = -direction
	raycast.target_position.x = -raycast.target_position.x
