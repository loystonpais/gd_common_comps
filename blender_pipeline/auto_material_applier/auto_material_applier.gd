## Used to auto apply materials to the mesh instances.
## 
## Runs when root is assigned.

@tool
extends Node

class_name AutoMaterialApplier

@export var root: Node
@export var resources: Array[AutoMaterialApplier_Pattern]

func _ready():
	if Engine.is_editor_hint() and root != null:
		print_rich("[font_size=25]%s/%s[/font_size] -> AutoMaterialApplier" % [root.name, name])
		
		var children = root.get_children()
		
		for res in resources:
			var pattern = res.pattern
			var surface_override_materials = res.surface_override_materials
			
			var regex = RegEx.new()
			regex.compile(pattern)
			
			if not regex.is_valid():
				push_error("Given regex is not valid")
				
			for child in children:
				if regex.search(child.name):
					if child is MeshInstance3D:
						for surface in surface_override_materials:
							if surface.id < child.get_surface_override_material_count():
								child.set_surface_override_material(surface.id, surface.material)
								print_rich("%s assigned %s at surface %s" % [ child.name, res.resource_name, surface.id ])
							else:
								print_rich("[color=red]Total surface override materials for %s is less than %s[/color]" % [ child.name, surface.id ])
					else:
						print_rich("[color=red]Child %s is not MeshInstance3D[/color]" % child.name)
						
