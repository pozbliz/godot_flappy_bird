extends Node


@export var pipe_scene: PackedScene

func _ready() -> void:
	$ObstacleTimer.timeout.connect(_on_obstacle_timer_timeout)

func _process(delta: float) -> void:
	pass

func _on_obstacle_timer_timeout():
	print("Spawning pipes")
	spawn_pipes()
	
func spawn_pipes():
	var pipes = pipe_scene.instantiate()
	add_child(pipes)
