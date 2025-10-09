extends CharacterBody3D

@onready var target: Node3D = $"../map/Navpoint/Target"
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var rand_pos := target.global_position
	if not is_on_floor():
		velocity += get_gravity() * delta
	navigation_agent_3d.set_target_position(rand_pos)
	
	var current_agenet_position = global_position
	var next_path_position = navigation_agent_3d.get_next_path_position()
	
	velocity = current_agenet_position.direction_to(next_path_position) * 50
	rotation.y = clamp(rotation.y, 0.0, 0.0)
	#velocity.y = clamp(velocity.y, 0.0, 0.0)
	look_at(rand_pos)
	move_and_slide()
