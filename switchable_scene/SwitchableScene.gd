@icon("./SwitchableScene.svg")

extends Node3D

class_name SwitchableScene

var disabled: bool :
	set(value):
		if value == true:
			visible = false
			disabled = true
			#process_mode = PROCESS_MODE_DISABLED
		else:
			visible = true
			disabled = false
			#process_mode = PROCESS_MODE_INHERIT
