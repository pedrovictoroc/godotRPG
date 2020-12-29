extends Node2D

func _process(delta):
	if (Input.is_action_just_pressed("attack")):
		
		#Load scene
		var GrassEffect = load("res://Grass/GrassEffect.tscn")
		#Get instance
		var grassEffect = GrassEffect.instance()
		#Get root scene
		var mainScene = get_tree().current_scene
		
		mainScene.add_child(grassEffect)
		grassEffect.global_position = global_position
		
		queue_free()
