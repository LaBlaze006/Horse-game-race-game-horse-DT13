extends Node3D

@onready var global = get_node("/root/Global")

var lock : bool = true
var can_finish : int = 0
var time : float = 0.0
var can_time : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Timer
	if can_time:
		time += delta
		# Makes target move
	if not lock:
		$AnimationPlayer.play("target_move")
		
	# Start
	if global.start:
		_lock(3.5)

# Restart
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
		global.start = false
		global.end = false


func _lock(_time):
	await get_tree().create_timer(_time).timeout
	lock = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Horse Indiana Jones":
		if can_finish == 5:
			can_time = false
			$Label.visible = true
			$Label2.visible = true
			$Label3.text = str(time)
			global.end = true


func _on_midway_body_entered(body: Node3D) -> void:
	if body.name == "Horse Indiana Jones":
		can_finish += 1
		if can_finish == 1:
			$"Midway/Checkpoint 1".disabled = true
		elif can_finish == 2:
			$"Midway/Checkpoint 2".disabled = true
		elif can_finish ==3:
			$"Midway/Checkpoint 3".disabled = true
		elif can_finish == 4:
			$"Midway/Checkpoint 4".disabled = true
		elif can_finish == 5:
			$"Midway/Checkpoint 5".disabled = true
