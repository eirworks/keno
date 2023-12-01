extends PanelContainer

# Mostly, this script only handle all the buttons clicks
# and send another bet signal to the parent.
signal BetAdded(type, amount, rate)

const BetType = preload("res://bet_types.gd").BetType

func add_bet(type : BetType) -> void:
	emit_signal("BetAdded")

func _on_even_btn_pressed():
	pass # Replace with function body.
