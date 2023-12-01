extends CenterContainer

@export var number : int = 1
@export var exposed : bool = false

func _ready():
	$BallNumber.text = str(number)
	$BallNumber.visible = false
	
func set_number(num: int) -> void :
	number = num
	$BallNumber.text = str(number)

func toggle_expose():
	exposed = !exposed
	if exposed:
		$Ball.texture = load("res://assets/red_ball.png")
		$BallNumber.visible = true
	else:
		$Ball.texture = load("res://assets/purple_ball.png")
		$BallNumber.visible = false
		
