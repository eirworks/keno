extends Node

var cash : float = 0.0
var day : int = 1
var numbers : Array = []
var total : int = 0
var displayed_total : int = 0

var total_wins : float = 0
var total_loses : float = 0

var bet_amount : float = 5

var database : Dictionary = {
	"steal_from_parent": 0
}

var bets : Array = []

const MIN_BALL = 1
const MAX_BALL = 80
const DRAWING_BALLS = 20
const BET_INCREMENT = 5

# Why 811? I don't even know...
# I got this value from the gambling site.
const BS_MIDDLE = 811


func generate_numbers():
	var nums = range(MIN_BALL, MAX_BALL)
	nums.shuffle()
	numbers = nums.slice(0, DRAWING_BALLS)
	
	var sum = 0
	for i in numbers:
		sum += i
	total = sum

func get_total_bets() -> float:
	var total : float = 0
	for bet in bets:
		total += bet.amount
	return total
	
func get_total_rates() -> float:
	var total : float = 0
	for bet in bets:
		total += (bet.amount * bet.rate) - bet.amount
	return total
	
func get_total_bet_and_rates() -> float:
	var total : float = 0
	for bet in bets:
		total += (bet.amount * bet.rate)
	return total
	
func can_add_bet(rated_amount: float) -> bool:
	return (get_total_bets() + rated_amount) <= cash

func set_cash(amount : float):
	cash = amount
	
func add_cash(amount: float):
	cash += amount
	
func add_day(amount: int = 1):
	day += amount

func reset_wins_loses():
	total_wins = 0
	total_loses = 0
