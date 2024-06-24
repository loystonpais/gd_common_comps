extends Node

class_name Interaction

@export var description: String
@export var brief: String

func interact():
	push_error("No interaction set")
