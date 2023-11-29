class Roll:
	
	const MIN_BALL = 1
	const MAX_BALL = 80
	const DRAWING_BALLS = 20
	
	var numbers : Array = []
	
	func generateNumbers() -> void:
		var nums = range(MIN_BALL, MAX_BALL)
		nums.shuffle()
		numbers = nums.slice(1, DRAWING_BALLS)
