class_name KenoBet

const BetType = preload("res://bet_types.gd").BetType

var type: BetType
var amount : float = 0.0
var rate : float = 0.0

const RATE_EVEN = 1.95
const RATE_ODD = 1.95
const RATE_SMALLER = 1.95
const RATE_BIGGER = 1.95
const RATE_DRAGON = 1.95
const RATE_TIGER = 1.95
const RATE_DRAGON_TIGER_TIE = 9.0
const RATE_EL_GOLD = 9.20
const RATE_EL_WOOD = 4.60
const RATE_EL_WATER = 2.40
const RATE_EL_FIRE = 4.60
const RATE_EL_EARTH = 9.20

func _init(bet_type: BetType, bet_amount: float, bet_rate : float):
	type = bet_type
	amount = bet_amount
	rate = bet_rate
	
func is_winning(total: int) -> bool:
	var total_list_str : Array = "{total}".format({"total": str(total)}).split("")
	total_list_str.reverse()
	var dragon = int(total_list_str[1])
	var tiger =  int(total_list_str[0])
	
	if type == BetType.Odd:
		return total % 2 != 0
	elif type == BetType.Even:
		return total % 2 == 0
	elif type == BetType.Bigger:
		return total >= Keno.BS_MIDDLE
	elif type == BetType.Smaller:
		return total < Keno.BS_MIDDLE
	elif type == BetType.Tiger:
		return dragon < tiger
	elif type == BetType.Dragon:
		return dragon > tiger
	elif type == BetType.DragonTigerTie:
		return dragon == tiger
	elif type == BetType.ElementGold:
		return total >= 210 && total <= 695
	elif type == BetType.ElementWood:
		return total >= 696 && total <= 763
	elif type == BetType.ElementWater:
		return total >= 764 && total <= 855
	elif type == BetType.ElementFire:
		return total >= 856 && total <= 923
	elif type == BetType.ElementEarth:
		return total > 923
	else:
		return false
