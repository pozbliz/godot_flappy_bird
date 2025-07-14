extends Area2D


const GAP_SIZE: int = 150
const PIPE_SPEED: int = 180
var screen_height: int

@onready var top_pipe = $TopPipe
@onready var top_collision = $TopCollision
@onready var bottom_pipe = $BottomPipe
@onready var bottom_collision = $BottomCollision

signal increase_score
signal player_hit


func _ready() -> void:
	add_to_group("obstacles")
	screen_height = get_viewport_rect().size.y
	
	$ScoreArea.body_entered.connect(_on_score_body_entered)
	self.body_entered.connect(_on_body_entered)

	setup_random_pipes()

func _process(delta: float) -> void:
	position.x -= PIPE_SPEED * delta
	
	if position.x < -200:
		queue_free()

func setup_random_pipes():
	# Horizontal start position just outside screen
	position.x = get_viewport_rect().size.x + 100
	
	# Vertical position of the random gap
	var gap_position: float = randf_range(-150.0, 150.0)
	
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
	
	# Position the ScoreArea in the gap
	$ScoreArea.position.y = (screen_height / 2) + gap_position
	
func _on_body_entered(body):
	if body.name == "Player":
		player_hit.emit()
	
func _on_score_body_entered(body):
	if body.name == "Player":
		increase_score.emit()
	
