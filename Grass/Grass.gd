extends Node2D

func create_grass_effect():	
	#Load scene
	var GrassEffect = load("res://Grass/GrassEffect.tscn")
	#Get instance
	var grassEffect = GrassEffect.instance()
	#Get root scene
	var mainScene = get_tree().current_scene
	#Set instance
	mainScene.add_child(grassEffect)
	#Set position of instance
	grassEffect.global_position = global_position
	


func _on_Hurtbox_area_entered(area):
	print(area)
	create_grass_effect()
	queue_free()
