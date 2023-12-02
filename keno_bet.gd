class_name KenoBet

const BetType = preload("res://bet_types.gd").BetType

var type: BetType
var amount : float = 0.0
var rate : float = 0.0

const RATE_EVEN = 1.95
const RATE_ODD = 1.95
const RATE_SMALLER = 1.95
const RATE_BIGGER = 1.95

func _init(bet_type: BetType, bet_amount: float, bet_rate : float):
	type = bet_type
	amount = bet_amount
	rate = bet_rate
