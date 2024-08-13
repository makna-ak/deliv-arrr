extends Control

func _physics_process(delta):
	var highscore = str("%10.1f" % (Player.highScore))
	$Highscore.text = "Highscore: %s" % highscore

func _on_start_pressed():
	$Click.play()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	Player.is_alive = true
	Player.current_status = Player.Status.EMPTY
	Player.target = null


func _on_quit_pressed():
	$Click.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
