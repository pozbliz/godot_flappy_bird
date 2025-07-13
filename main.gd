extends Node


@export var pipe_scene: PackedScene
@onready var score: int = 0

func _ready() -> void:
	$ObstacleTimer.timeout.connect(_on_obstacle_timer_timeout)
	$Obstacles.increase_score.connect(on_obstacles_increase_score)
	$MainMenu.new_game.connect(on_main_menu_new_game)
	
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
	
	$ObstacleTimer.start()

func _on_obstacle_timer_timeout():
	print("timer timeout")
	spawn_pipes()
	
func spawn_pipes():
	var pipes = pipe_scene.instantiate()
	add_child(pipes)

func on_obstacles_increase_score():
	score += 1
	$HUD.update_score(score)
	
func on_main_menu_new_game():
	new_game()
