extends Area3D

@export var anim_player : Node



func _player_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		anim_player.play("door_open")

func _player_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		anim_player.play("door_close")
