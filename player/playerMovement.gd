extends PlatformerController2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

enum States {
	IDLE,
	WALK,
	JUMP
}

enum Materials {
	GRASS,
	WATER,
	TILE
}

var current_state = States.IDLE
var current_floor = null

func _physics_process(delta):
	if Player.is_alive:
		super._physics_process(delta)
		update_state()
		update_animation()
		update_direction()

func update_state():
	if is_on_floor():
		current_state = States.WALK if abs(velocity.x) > 0.1 else States.IDLE
	else:
		current_state = States.JUMP

func update_animation():
	match current_state:
		States.IDLE:
			animation_player.play("idle")
		States.WALK:
			animation_player.play("walk")
		States.JUMP:
			animation_player.play("jump")

func update_direction():
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

func _on_juan_body_entered(body):
	if Player.target == "Juan":
		$Success.play()
		Player.target = null
		Player.current_status = Player.Status.EMPTY

func _on_sebastian_body_entered(body):
	if Player.target == "Sebastian":
		$Success.play()
		Player.target = null
		Player.current_status = Player.Status.EMPTY

func _on_roger_body_entered(body):
	if Player.target == "Roger":
		$Success.play()
		Player.target = null
		Player.current_status = Player.Status.EMPTY

func _on_patrick_body_entered(body):
	if Player.target == "Patrick":
		$Success.play()
		Player.target = null
		Player.current_status = Player.Status.EMPTY

func _on_area_2d_area_entered(area):
	if area.is_in_group("chest"):
		$Interaction.visible = true

func _on_area_2d_area_exited(area):
	if area.is_in_group("chest"):
		$Interaction.visible = false

func _on_foot_area_2d_2_area_entered(area):
	if area.is_in_group("grass"):
		current_floor = Materials.GRASS
		_play_footstep_grass_audio()
	elif area.is_in_group("tile"):
		current_floor = Materials.TILE
		_play_footstep_grass_audio()

func _play_footstep_grass_audio():
	if current_floor == Materials.GRASS:
		$Footsteps_Grass.pitch_scale = randf_range(.8, 3)
		$Footsteps_Grass.play()
	elif current_floor == Materials.TILE:
		$Footsteps_Tile.pitch_scale = randf_range(.8, 3)
		$Footsteps_Tile.play()
