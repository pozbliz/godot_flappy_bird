extends Node


@export var pipe_scene: PackedScene

func _ready() -> void:
	$ObstacleTimer.timeout.connect(_on_obstacle_timer_timeout)

func _process(delta: float) -> void:
	pass
	
func new_game():
	$MainMenu.hide()
	$HUD.show()
	$Obstacles.show()
	$Player.show()

func _on_obstacle_timer_timeout():
	print("Obstacle timer timeout")
	spawn_pipes()
	
func spawn_pipes():
	print("Spawning pipes")
	var pipes = pipe_scene.instantiate()
	add_child(pipes)
