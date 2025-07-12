extends StaticBody2D


const GAP_SIZE: int = 150
const PIPE_SPEED: int = 200
var screen_height: int = get_viewport_rect().size.y

@onready var top_pipe = $TopPipe
@onready var top_collision = $TopCollision
@onready var bottom_pipe = $BottomPipe
@onready var bottom_collision = $BottomCollision


func _ready() -> void:
	setup_random_pipes()

func _process(delta: float) -> void:
	pass

func setup_random_pipes():
	# Horizontal start position just outside screen
	var starting_x: int = get_viewport_rect().size.x
	
	# Vertical position of the random gap
	var gap_position: float = randf_range(-200.0, 200.0)
	$ScoreArea/CollisionShape2D.position.y = gap_position
	
	var top_height = (screen_height / 2) + gap_position - (GAP_SIZE / 2)
	var bottom_height = (screen_height / 2) - gap_position - (GAP_SIZE / 2)
	
	top_pipe.position.y = top_height / 2
	bottom_pipe.position.y = screen_height - (bottom_height / 2)
	
	top_pipe.scale.y = top_height / top_pipe.texture.get_height()
	bottom_pipe.scale.y = bottom_height / bottom_pipe.texture.get_height()
	
	top_collision.scale.y = top_pipe.scale.y
	bottom_collision.scale.y = bottom_pipe.scale.y
	
	top_collision.position.y = top_pipe.position.y
	bottom_collision.position.y = bottom_pipe.position.y
	
	await get_tree().create_timer(2).timeout
