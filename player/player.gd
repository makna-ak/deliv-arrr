extends Node

enum Status {
	FULL,
	EMPTY,
	WIN
}

var is_alive = true
var current_status = Status.EMPTY
var target = null
var score = 0
var highScore = 0

func _physics_process(delta):
	if score > highScore:
		highScore = score
