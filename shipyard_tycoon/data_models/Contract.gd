class_name Contract
extends Resource

@export var id: String = ""
@export var title: String = ""
@export var revenue: float = 0.0
@export var material_requirements: Dictionary = {}
@export var work_hours_required: int = 0
@export var penalty: float = 0.0
@export var deadline_days: int = 0
@export var work_hours_completed: int = 0
@export var days_remaining: int = 0
@export var status: String = "available"

func to_dict() -> Dictionary:
	return {
		"id": id,
		"title": title,
		"revenue": revenue,
		"material_requirements": material_requirements,
		"work_hours_required": work_hours_required,
		"penalty": penalty,
		"deadline_days": deadline_days,
		"work_hours_completed": work_hours_completed,
		"days_remaining": days_remaining,
		"status": status,
	}

static func from_dict(data: Dictionary) -> Contract:
	var contract := Contract.new()
	contract.id = data.get("id", "")
	contract.title = data.get("title", "")
	contract.revenue = data.get("revenue", 0.0)
	contract.material_requirements = data.get("material_requirements", {})
	contract.work_hours_required = data.get("work_hours_required", 0)
	contract.penalty = data.get("penalty", 0.0)
	contract.deadline_days = data.get("deadline_days", 0)
	contract.work_hours_completed = data.get("work_hours_completed", 0)
	contract.days_remaining = data.get("days_remaining", 0)
	contract.status = data.get("status", "available")
	return contract
