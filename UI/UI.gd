extends CanvasLayer

@onready var label = $UI/MarginContainer/Timer
@onready var timer = $UI/MarginContainer/Timer/Timer

func _physics_process(delta):
	label.text = str("%10.1f" % (timer.time_left)) + " s"
	if timer.time_left < 10:
		label.add_theme_color_override("font_color", "red")
	elif timer.time_left < 20:
		label.add_theme_color_override("font_color", "orange")
	else:
		label.add_theme_color_override("font_color", "green")
	
	if !Player.is_alive:
		timer.paused
	
	if Player.target != null:
		$UI/NinePatchRect4/Target.texture = load("res://assets/characters/%s.tres" % Player.target)
	else:
		$UI/NinePatchRect4/Target.texture = null

	if Player.current_status == Player.Status.WIN:
		Player.is_alive = false
		timer.paused = true
		Player.score = timer.time_left
		var score = str("%10.1f" % (Player.score))
		$Win/VBoxContainer/Highscore.text = "Score: %s" % score
		$Win.visible = true 


func _on_timer_timeout():
	$UI.visible = false
	$GameOver.visible = true
	Player.is_alive = false


func _on_fall_death_body_entered(body):
	timer.paused = true
	$UI.visible = false
	Player.is_alive = false
	$GameOver.visible = true


func _on_pause_pressed():
	$Click.play()
	timer.paused = true
	Player.is_alive = false
	$Paused.visible = true


func _on_resume_button_pressed():
	$Click.play()
	$Paused.visible = false
	Player.is_alive = true
	timer.paused = false
