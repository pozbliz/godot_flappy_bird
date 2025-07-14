extends ParallaxBackground


const SCROLL_SPEED: float = 180.0
var is_scrolling: bool = false

func _process(delta):
	if is_scrolling:
		scroll_base_offset.x -= SCROLL_SPEED * delta

func start_scrolling():
	is_scrolling = true
	
func stop_scrolling():
	is_scrolling = false
