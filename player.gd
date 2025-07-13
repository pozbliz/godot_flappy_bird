extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var game_started: bool = false
var gravity_enabled: bool = false


func _physics_process(delta: float) -> void:
	# Only apply gravity if game has started
	if not is_on_floor() and gravity_enabled:
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("flap"):
		if not game_started:
			start_game()
		else:
			flap()
	
	if game_started:
		move_and_slide()

func start_game():
	game_started = true
	gravity_enabled = true
	flap()

func flap():
	if game_started:
		velocity.y = JUMP_VELOCITY
	
func start(pos):
	position = pos
	game_started = false
	$AnimatedSprite2D.play("default")
	show()
	
func play_death_animation():
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	hide()
