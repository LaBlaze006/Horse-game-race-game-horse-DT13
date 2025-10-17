extends CharacterBody3D

@onready var target: Node3D = $"../map/Navpoint/Target"
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var global = get_node("/root/Global")

var can_countdown : bool = true
var lock : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Sets target
	var rand_pos := target.global_position
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not lock:
		navigation_agent_3d.set_target_position(rand_pos)
	
	# Start
	if global.start:
		_lock(3.5)
	
	# Movement
	var current_agenet_position = global_position
	var next_path_position = navigation_agent_3d.get_next_path_position()
	
	velocity = current_agenet_position.direction_to(next_path_position) * 45
	rotation.y = clamp(rotation.y, 0.0, 0.0)
	#velocity.y = clamp(velocity.y, 0.0, 0.0)
	look_at(rand_pos)
	# Restart
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
	move_and_slide()
	
	
func _lock(_time):
	await get_tree().create_timer(_time).timeout
	lock = false
