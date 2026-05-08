class_name Loan
extends Resource

@export var principal: float = 0.0
@export var interest_rate: float = 0.05
@export var remaining_days: int = 0

func to_dict() -> Dictionary:
	return {
		"principal": principal,
		"interest_rate": interest_rate,
		"remaining_days": remaining_days,
	}

static func from_dict(data: Dictionary) -> Loan:
	var loan := Loan.new()
	loan.principal = data.get("principal", 0.0)
	loan.interest_rate = data.get("interest_rate", 0.05)
	loan.remaining_days = data.get("remaining_days", 0)
	return loan
