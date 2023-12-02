extends PanelContainer

const BetType = preload("res://bet_types.gd").BetType

@export var bet_type : BetType
@export var bet : float = 0.0
@export var bet_rate : float = 0.0
@export var failed : bool = false
var text : String = ""

func _ready():
	var text = {
		"type": translate_bet_type(bet_type),
		"bet": str(bet),
		"paid": str(bet * bet_rate)
	}
	$MarginContainer/Label.text = "{type} ${bet} (${paid})".format(text)

func translate_bet_type(type: BetType) -> String:
	return BetType.keys()[type]
		
