extends Node3D #Door v2.0

var opened = false
@export var locked = false
@export var albedo_texture: Texture2D
@onready var door_mesh: MeshInstance3D = $hinge/closet_door
@onready var sfx_open: AudioStreamPlayer3D = $CreakingDoor
@onready var sfx_lock: AudioStreamPlayer3D = $DoorLock

func _ready():
	if albedo_texture:
		var new_material = StandardMaterial3D.new()
		new_material.albedo_texture = albedo_texture
		door_mesh.set_surface_override_material(0, new_material)

func toggle_door():
	if locked:
		print("DoorLocked")
		sfx_lock.play()
		return
	if $AnimationPlayer.is_playing():
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("door_open")
		sfx_open.play()
	else:
		$AnimationPlayer.play_backwards("door_open")
		sfx_open.play()

func get_interaction_text() -> String:
	if locked:
		return "Locked"
	if opened:
		return "Close Door"
	return "Open Door"

func unlock_door():
	locked = false
	print("Door unlocked")
