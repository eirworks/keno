extends CenterContainer

@export var number : int = 1

func _ready():
	$BallNumber.text = str(number)
