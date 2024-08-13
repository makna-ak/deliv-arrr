extends Node2D

func _on_try_again_button_pressed():
	$CanvasLayer/Click.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().reload_current_scene()
	Player.is_alive = true
	Player.current_status = Player.Status.EMPTY
	Player.target = null


func _on_back_to_menu_button_pressed():
	$CanvasLayer/Click.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://scenes/title.tscn")
