extends Node2D

const NumberBall = preload("res://number_ball.tscn")
@export var cash : int = 0
var day : int = 1
var numbers: Array = []
var total_numbers : int = 0

const MIN_BALL = 1
const MAX_BALL = 80
const DRAWING_BALLS = 20

func _ready():
	update_cash()
	update_day()
	generateNumbers()
	print(numbers.size())
	print(numbers)
	print(total_numbers)
	
	update_balls()
	update_result()
	
func generateNumbers():
	var nums = range(MIN_BALL, MAX_BALL)
	nums.shuffle()
	numbers = nums.slice(0, DRAWING_BALLS)
	
	var sum = 0
	for i in numbers:
		sum += i
	total_numbers = sum
	
func update_balls():
	# Remove existing balls
	var children = $BaseUI/Container/BallContainer/HBoxContainer/BallsGrid.get_children()
	
	for c in children:
		c.queue_free()
		
	$BaseUI/Container/BetBtn.disabled = true
	
	for n in numbers:
		await get_tree().create_timer(0.1).timeout
		var ball = NumberBall.instantiate()
		ball.number = n
		
		$BaseUI/Container/BallContainer/HBoxContainer/BallsGrid.add_child(ball)
	
	$BaseUI/Container/BetBtn.disabled = false
	
func update_day(addition: int = 0):
	if addition > 0:
		day += addition
	$BaseUI/Container/TopStatusBar/MarginContainer/HBoxContainer/DayLabel.text = "Day {day}".format({"day": day})

func update_cash(amount: int = 0):
	if amount > 0:
		cash += amount
	$BaseUI/Container/TopStatusBar/MarginContainer/HBoxContainer/MoneyLabel.text = "$ {cash}".format({"cash": str(cash)})
	
func update_result():
	$BaseUI/Container/ResultContainer/MarginContainer/VBoxContainer/CurrentResultContainer/ResultNumberLabel.text = str(total_numbers)
	
	var oddEvenResult = "ODD"
	if total_numbers % 2 == 0:
		oddEvenResult = "EVEN"
	$BaseUI/Container/ResultContainer/MarginContainer/VBoxContainer/CurrentResultContainer/OddEvenLabel.text = oddEvenResult
	

func roll_the_balls():
	update_cash()
	update_day()
	generateNumbers()
	update_balls()
	update_result()

func _on_get_money_btn_pressed():
	$GetMoneyUI.visible = !$GetMoneyUI.visible


func _on_quit_money_scheme_btn_pressed():
	$GetMoneyUI.visible = false


func _on_money_from_parent_btn_pressed():
	update_cash(100)


func _on_bet_btn_pressed():
	roll_the_balls()
