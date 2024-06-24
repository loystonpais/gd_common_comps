extends Node

signal on_interaction_changed(new_interaction: Interaction)

@export var ray: RayCast3D
@export var trigger_only_once: bool

var interaction

func _ready():
	assert(ray != null)

func _process(delta):
	var new_interaction
	if ray.is_colliding():
		var collision = ray.get_collider()
		
		if collision is InteractableArea:
			var interactable_area = collision
			new_interaction = interactable_area.interaction
		else:
			new_interaction = null
	else:
		new_interaction = null
		
	if interaction != new_interaction:
		on_interaction_changed.emit(new_interaction)
		
	interaction = new_interaction
