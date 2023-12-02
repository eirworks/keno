extends PanelContainer

# Mostly, this script only handle all the buttons clicks
# and send another bet signal to the parent.
signal bet_added

const BetType = preload("res://bet_types.gd").BetType
const KenoBet = preload("res://keno_bet.gd")
const BetBadge = preload("res://bet_badge.tscn")

func _ready():
	#for i in 100:
		#var kb = KenoBet.new(BetType.Odd, 5, KenoBet.RATE_EVEN)
		#Keno.bets.append(kb)
	
	update_bet_badges()

func update_bet_amout():
	$VBoxContainer/HBoxContainer/BetAmount.text = "${amount}".format({"amount": Keno.bet_amount})
	if Keno.bet_amount > Keno.BET_INCREMENT:
		$VBoxContainer/HBoxContainer/DecreaseBetButton.disabled = false
	else:
		$VBoxContainer/HBoxContainer/DecreaseBetButton.disabled = true
		
func update_bet_badges():
	var badges = $VBoxContainer/MarginContainer/ScrollContainer/PaidBets.get_children()
	
	for b in badges:
		b.queue_free()
		
	for b in Keno.bets:
		var badge = BetBadge.instantiate()
		badge.bet_type = b.type
		badge.bet = b.amount
		badge.bet_rate = b.rate
		
		$VBoxContainer/MarginContainer/ScrollContainer/PaidBets.add_child(badge)
		
func remove_same_bet_type(type: BetType):
	var loop = 0
	for bet in Keno.bets:
		if bet.type == type:
			# return the money
			Keno.add_cash(Keno.bets[loop].amount * Keno.bets[loop].rate)
			
			# remove bet
			Keno.bets.remove_at(loop)
		loop += 1

func bet_buttons_clicked(type: BetType, amount: float, rate: float):
	var bet = KenoBet.new(type, amount, rate)
	remove_same_bet_type(type)
	Keno.bets.append(bet)
	Keno.add_cash(-1 * (bet.amount * bet.rate))
	update_bet_badges()
	emit_signal("bet_added")

func _on_increase_bet_button_pressed():
	Keno.bet_amount += Keno.BET_INCREMENT
	update_bet_amout()

func _on_decrease_bet_button_pressed():
	if Keno.bet_amount >= Keno.BET_INCREMENT:
		Keno.bet_amount -= Keno.BET_INCREMENT
	update_bet_amout()


func _on_set_5_button_pressed():
	Keno.bet_amount = 5
	update_bet_amout()


func _on_set_50_button_pressed():
	Keno.bet_amount = 50
	update_bet_amout()


func _on_set_50_button_2_pressed():
	Keno.bet_amount = 100
	update_bet_amout()


func _on_set_50_button_3_pressed():
	Keno.bet_amount = 500
	update_bet_amout()

func _on_even_btn_pressed():
	bet_buttons_clicked(BetType.Even, Keno.bet_amount, KenoBet.RATE_EVEN)


func _on_clear_bets_button_pressed():
	var loop = 0
	for bet in Keno.bets:
		# returning money
		var returned_cash = Keno.bets[loop].amount * Keno.bets[loop].rate
		Keno.add_cash(returned_cash)
		print("Returning {num}".format({"num": str(returned_cash)}))
		loop+=1
		
	Keno.bets.clear()
	update_bet_badges()
	emit_signal("bet_added")


func _on_odd_btn_pressed():
	bet_buttons_clicked(BetType.Odd, Keno.bet_amount, KenoBet.RATE_ODD)
