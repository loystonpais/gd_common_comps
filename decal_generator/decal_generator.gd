@tool

@icon("./Decal.svg")

extends Node

enum Mode {
	SIMPLE,
}

@export var run : bool :
	set = run_in_engine

@export var mode: Mode
@export var add_to_node: Node = self
@export_global_dir var texture_directory = ""

func simple_mode():
	var files = DirAccess.open(texture_directory).get_files()
	
	for file in files:
		if file.ends_with(".png") or file.ends_with(".jpg"):
			var full_path = texture_directory + "/" + file
			var texture = load(full_path)
			var decal = Decal.new()
			decal.texture_albedo = texture
		
			add_to_node.add_child(decal)
			var node_name = texture.resource_path.get_file()
			decal.set_name("Decal_" + node_name)
			decal.owner =  get_tree().get_edited_scene_root()

func run_in_engine(value):
	run = false
	
	match mode:
		Mode.SIMPLE:
			simple_mode()
		_:
			push_error("Generation failed")
	
