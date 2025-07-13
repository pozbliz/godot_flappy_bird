extends Node


@export var pipe_scene: PackedScene
var score: int

func _ready() -> void:
	$ObstacleTimer.timeout.connect(_on_obstacle_timer_timeout)
	$MainMenu.new_game.connect(_on_main_menu_new_game)
	$Walls.body_entered.connect(_on_walls_body_entered)
	
	$Player.hide()
	$HUD.hide()
	

func _process(delta: float) -> void:
	pass
	
func new_game():
	$MainMenu.hide()
	$HUD.show()
	$Player.show()
	
	score = 0
	$Player.start($PlayerStartPosition.position)
	$HUD.show_message("Press SPACEBAR to flap through the gaps!")
	$BackgroundMusic.play()
	$ParallaxBackground.start_scrolling()
	
	$ObstacleTimer.start()

func _on_obstacle_timer_timeout():
	spawn_pipes()
	
func spawn_pipes():
	var pipes = pipe_scene.instantiate()
	add_child(pipes)
	
	pipes.increase_score.connect(_on_obstacles_increase_score)
	pipes.player_hit.connect(_on_obstacles_player_hit)

func _on_obstacles_increase_score():
	score += 1
	$HUD.update_score(score)
	$PointSound.play()
	
func game_over():
	$ParallaxBackground.stop_scrolling()
	$BackgroundMusic.stop()
	$GameOverSound.play()
	$Player.game_started = false
	$Player.disable_input()
	$ObstacleTimer.stop()
	get_tree().call_group("obstacles", "queue_free")
	await $HUD.show_game_over()
	$HUD.hide()
	$MainMenu.show()
	
func _on_obstacles_player_hit():
	$Player.play_death_animation()
	game_over()
	
func _on_walls_body_entered(body):
	$Player.play_death_animation()
	game_over()
	
func _on_main_menu_new_game():
	new_game()
