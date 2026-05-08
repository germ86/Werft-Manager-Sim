class_name Employee
extends Resource

@export var employee_id: String = ""
@export var name: String = ""
@export var daily_wage: float = 120.0
@export var productivity: float = 1.0

func to_dict() -> Dictionary:
	return {
		"employee_id": employee_id,
		"name": name,
		"daily_wage": daily_wage,
		"productivity": productivity,
	}

static func from_dict(data: Dictionary) -> Employee:
	var employee := Employee.new()
	employee.employee_id = data.get("employee_id", "")
	employee.name = data.get("name", "")
	employee.daily_wage = data.get("daily_wage", 120.0)
	employee.productivity = data.get("productivity", 1.0)
	return employee
