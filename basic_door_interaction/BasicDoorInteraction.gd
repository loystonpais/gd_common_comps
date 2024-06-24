extends Interaction

@export var animation_player: AnimationPlayer
@export_enum("open", "close") var default_door_state: String = "close"
@export var open_animation_name: String = "open"
@export var close_animation_name: String = "close"
@export var open_message: String = "Open Door"
@export var close_message: String = "Close Door"

@export_group("Disable collision during animation")
@export var collision_shape: CollisionShape3D
@export var disable_collision: bool = true

var state
var running = false

func interact():
	if running: return
	running = true
	if disable_collision: collision_shape.disabled = true
	
	match state:
		"open":
			animation_player.play(close_animation_name)
			push_warning("playing close animation")
			brief = open_message
			state = "close"
		
		"close":
			animation_player.play(open_animation_name)
			push_warning("playing open animation")
			brief = close_message
			state = "open"

func on_animation_finished(animation_name):
	running = false
	if disable_collision: collision_shape.disabled = false
	push_warning("animation done")

func _ready():
	if animation_player != null:
		animation_player.connect("animation_finished", on_animation_finished)
	else:
		push_warning("Node is null")
	state = default_door_state
	brief = close_message if state == "open" else open_message
