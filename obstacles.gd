extends StaticBody2D


const GAP_SIZE: int = 150
const PIPE_SPEED: int = 200
var screen_height: int

@onready var top_pipe = $TopPipe
@onready var top_collision = $TopCollision
@onready var bottom_pipe = $BottomPipe
@onready var bottom_collision = $BottomCollision


func _ready() -> void:
	screen_height = get_viewport_rect().size.y
	$VisibleOnScreenEnabler2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	
	setup_random_pipes()

func _process(delta: float) -> void:
	position.x -= PIPE_SPEED * delta

func setup_random_pipes():
	# Horizontal start position just outside screen
	position.x = get_viewport_rect().size.x + 100
	
	# Vertical position of the random gap
	var gap_position: float = randf_range(-100.0, 100.0)
	$ScoreArea/CollisionShape2D.position.y = gap_position
	print("gap position: ", gap_position)
	
	var top_height = (screen_height / 2) + gap_position - (GAP_SIZE / 2)
	var bottom_height = (screen_height / 2) - gap_position - (GAP_SIZE / 2)
	print("top height: ", top_height)
	print("bottom height: ", bottom_height)
	
	top_pipe.position.y = top_height / 2
	bottom_pipe.position.y = screen_height - (bottom_height / 2)
	print("top pipe position: ", top_pipe.position.y)
	print("bottom pipe position: ", bottom_pipe.position.y)
	
	top_pipe.scale.y = top_height / top_pipe.texture.get_height()
	bottom_pipe.scale.y = bottom_height / bottom_pipe.texture.get_height()
	print("top pipe scale: ", top_pipe.position.y)
	print("bottom pipe scale: ", bottom_pipe.position.y)
	
	top_collision.scale.y = top_pipe.scale.y
	bottom_collision.scale.y = bottom_pipe.scale.y
	print("top pipe collision scale: ", top_collision.scale.y)
	print("bottom pipe collision scale: ", bottom_collision.scale.y)
	
	top_collision.position.y = top_pipe.position.y
	bottom_collision.position.y = bottom_pipe.position.y
	print("top pipe collision position: ", top_collision.position.y)
	print("bottom pipe collision position: ", bottom_collision.position.y)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
