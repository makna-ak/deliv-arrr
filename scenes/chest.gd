extends StaticBody2D

var player = false
var treasure = {"Juan": 1, "Sebastian": 2, "Roger": 3, "Patrick": 4}
var key = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("interaction") && player == true && Player.current_status == Player.Status.EMPTY && !treasure.is_empty():
		$Pick.play()
		key = treasure.keys().pick_random()
		Player.target = key
		Player.current_status = Player.Status.FULL
		treasure.erase(key)
	if treasure.is_empty() && Player.current_status == Player.Status.EMPTY:
		Player.current_status = Player.Status.WIN

func _on_area_2d_body_entered(body):
	player = true

func _on_area_2d_body_exited(body):
	player = false
