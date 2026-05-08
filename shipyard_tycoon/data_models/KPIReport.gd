class_name KPIReport
extends Resource

@export var day: int = 0
@export var revenue: float = 0.0
@export var expenses: float = 0.0
@export var cashflow: float = 0.0

func to_dict() -> Dictionary:
	return {
		"day": day,
		"revenue": revenue,
		"expenses": expenses,
		"cashflow": cashflow,
	}

static func from_dict(data: Dictionary) -> KPIReport:
	var kpi := KPIReport.new()
	kpi.day = data.get("day", 0)
	kpi.revenue = data.get("revenue", 0.0)
	kpi.expenses = data.get("expenses", 0.0)
	kpi.cashflow = data.get("cashflow", 0.0)
	return kpi
