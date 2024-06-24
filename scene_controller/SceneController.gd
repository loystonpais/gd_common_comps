@tool
extends Node

class_name SceneController

@export var scenes: Array[SwitchableScene]
@export var current_scene: SwitchableScene  :
	set(scene):
		if scene in scenes:
			switch_scene_to(scene)
			current_scene = scene
		else:
			push_error("Scene not in the list")
			current_scene = null

func switch_scene_to(scene):
	for _scene in scenes:
		if _scene == scene:
			_scene.visible = true
			_scene.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			_scene.visible = false
			_scene.process_mode = Node.PROCESS_MODE_DISABLED
