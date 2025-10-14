extends Node3D


var lock : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not lock:
		$AnimationPlayer.play("target_move")
		
	if Input.is_action_just_pressed("ui_accept"):
		_lock(3.5)


func _lock(_time):
	await get_tree().create_timer(_time).timeout
	lock = false
