extends Node2D

const NumberBall = preload("res://number_ball.tscn")
@export var cash : int = 0
var day : int = 1
var numbers: Array = []
var total_numbers : int = 0
var display_total_number : int = 0
var ball_pos : int = 1

var bets : Array = []

const MIN_BALL = 1
const MAX_BALL = 80
const DRAWING_BALLS = 20

const BS_MIDDLE = 811

func _ready():
	
	Keno.generate_numbers()
	Keno.add_cash(1000)
	
	update_cash()
	update_day()
	
	initial_balls()
	
func initial_balls():
	var children = $BaseUI/Container/BallContainer/HBoxContainer/BallsGrid.get_children()
	for c in children:
		c.queue_free()
		
	for n in Keno.numbers:
		var ball = NumberBall.instantiate()
		ball.number = n
		
		$BaseUI/Container/BallContainer/HBoxContainer/BallsGrid.add_child(ball)
	
	
func update_balls():
	
	# Hide all balls
	var children = $BaseUI/Container/BallContainer/HBoxContainer/BallsGrid.get_children()
	for ball in children:
		if ball.exposed:
			ball.toggle_expose()

	$BaseUI/Container/BetBtn.disabled = true
	
	Keno.displayed_total = 0
	
	update_result()
	
	await get_tree().create_timer(.75).timeout
	
	var loop = 0
	for ball in children:
		await get_tree().create_timer(0.1).timeout
		ball.set_number(Keno.numbers[loop])
		Keno.displayed_total += Keno.numbers[loop]
		ball.toggle_expose()
		update_result()
		
		loop+=1
	
	$BaseUI/Container/BetBtn.disabled = false
	
func update_day(addition: int = 0):
	Keno.add_day(addition)
	$BaseUI/Container/TopStatusBar/MarginContainer/HBoxContainer/DayLabel.text = "Day {day}".format({"day": Keno.day})

func update_cash(amount: int = 0):
	Keno.add_cash(amount)
	$BaseUI/Container/TopStatusBar/MarginContainer/HBoxContainer/MoneyLabel.text = "$ {cash}".format({"cash": str(Keno.cash)})
	
func update_result():
	$BaseUI/Container/ResultContainer/MarginContainer/VBoxContainer/CurrentResultContainer/ResultNumberLabel.text = str(Keno.displayed_total)
	
	var oddEvenResult = "ODD"
	if Keno.displayed_total > 0:
		if Keno.displayed_total % 2 == 0:
			oddEvenResult = "EVEN"
	else:
		oddEvenResult = "?????"
		
	$BaseUI/Container/ResultContainer/MarginContainer/VBoxContainer/CurrentResultContainer/OddEvenLabel.text = oddEvenResult
	

func roll_the_balls():
	
	Keno.generate_numbers()
	
	update_balls()
	
	update_cash()
	update_day()
	
	update_result()

func _on_get_money_btn_pressed():
	$GetMoneyUI.visible = !$GetMoneyUI.visible


func _on_quit_money_scheme_btn_pressed():
	$GetMoneyUI.visible = false


func _on_money_from_parent_btn_pressed():
	update_cash(100)


func _on_bet_btn_pressed():
	roll_the_balls()


func _on_bets_bet_added():
	$BaseUI/Container/BetConfirmation/MarginContainer/HBoxContainer/CalculationContainer/TotalBetLabel.text = "${amount}".format({"amount": Keno.get_total_bets()})
	update_cash()
