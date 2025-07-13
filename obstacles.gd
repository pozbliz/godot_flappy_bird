extends StaticBody2D


const GAP_SIZE: int = 150
const PIPE_SPEED: int = 200
var screen_height: int

@onready var top_pipe = $TopPipe
@onready var top_collision = $TopCollision
@onready var bottom_pipe = $BottomPipe
@onready var bottom_collision = $BottomCollision
@onready var enabler = $VisibleOnScreenEnabler2D

signal increase_score


func _ready() -> void:
	screen_height = get_viewport_rect().size.y
	
	$VisibleOnScreenEnabler2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	$ScoreArea.area_entered.connect(_on_score_area_entered)

	setup_random_pipes()
	setup_visibility_enabler()

func _process(delta: float) -> void:
	position.x -= PIPE_SPEED * delta

func setup_random_pipes():
	# Horizontal start position just outside screen
	position.x = get_viewport_rect().size.x
	print("pipe position x setup: ", position.x)
	
	# Vertical position of the random gap
	var gap_position: float = randf_range(-100.0, 100.0)
	
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
	
	$ScoreArea/CollisionShape2D.position.y = (screen_height / 2) + gap_position
	
func setup_visibility_enabler():
	# Calculate pipe width based on actual sprite size
	var pipe_width = top_pipe.texture.get_width() * top_pipe.scale.x
	
	enabler.rect = Rect2(
		-pipe_width/2,
		-screen_height/2,
		pipe_width,
		screen_height
	)

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("removing pipe")
	queue_free()
	
func _on_score_area_entered():
	increase_score.emit()
	
