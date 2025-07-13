extends Node


@export var pipe_scene: PackedScene
var score: int

func _ready() -> void:
	$ObstacleTimer.timeout.connect(_on_obstacle_timer_timeout)
	$Obstacles.increase_score.connect(on_obstacles_increase_score)
	$MainMenu.new_game.connect(on_main_menu_new_game)
	$Obstacles.player_hit.connect(on_obstacles_player_hit)
	
	$Player.hide()
	$Obstacles.hide()
	$HUD.hide()
	

func _process(delta: float) -> void:
	pass
	
func new_game():
	$MainMenu.hide()
	$HUD.show()
	$Obstacles.show()
	$Player.show()
	
	score = 0
	$Player.start($PlayerStartPosition.position)
	$HUD.show_message("Press SPACEBAR to flap through the gaps!")
	await get_tree().create_timer(2).timeout
	
	$ObstacleTimer.start()

func _on_obstacle_timer_timeout():
	spawn_pipes()
	
func spawn_pipes():
	var pipes = pipe_scene.instantiate()
	add_child(pipes)
	
	pipes.increase_score.connect(on_obstacles_increase_score)

func on_obstacles_increase_score():
	score += 1
	$HUD.update_score(score)
	
func game_over():
	$ObstacleTimer.stop()
	$HUD.show_game_over()
	await get_tree().create_timer(1.0).timeout
	$HUD.hide()
	$MainMenu.show()
	
func on_obstacles_player_hit():
	game_over()
	
func on_main_menu_new_game():
	new_game()
