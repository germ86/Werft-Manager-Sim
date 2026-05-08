extends Node

@export var daily_work_capacity_base: int = 8

func _ready() -> void:
	EventBus.day_passed.connect(_on_day_passed)

func generate_dummy_contract() -> Contract:
	var contract := Contract.new()
	contract.id = "C-%d" % Time.get_unix_time_from_system()
	contract.title = "Harbor Tug Retrofit"
	contract.revenue = 12000.0
	contract.penalty = 2500.0
	contract.work_hours_required = 120
	contract.deadline_days = 20
	contract.days_remaining = contract.deadline_days
	contract.material_requirements = {"steel": 30}
	contract.status = "available"
	GameManager.current_company.contracts.append(contract)
	print("[ContractManager] generated ", contract.id)
	return contract

func accept_contract(contract_id: String) -> bool:
	var contract := _find_contract(contract_id)
	if contract == null or contract.status != "available":
		return false
	if not InventoryManager.consume_materials(contract.material_requirements):
		print("[ContractManager] cannot accept; missing materials")
		return false
	contract.status = "in_progress"
	EventBus.contract_accepted.emit(contract.id)
	print("[ContractManager] accepted ", contract.id)
	return true

func _on_day_passed(_current_day: int) -> void:
	for contract in GameManager.current_company.contracts:
		if contract.status != "in_progress":
			continue
		contract.days_remaining -= 1
		var daily_capacity := _calculate_daily_capacity()
		contract.work_hours_completed += daily_capacity
		var progress := min(float(contract.work_hours_completed) / max(1.0, float(contract.work_hours_required)), 1.0)
		EventBus.contract_progress_updated.emit(contract.id, progress)
		if contract.work_hours_completed >= contract.work_hours_required:
			contract.status = "completed"
			FinanceManager.add_income(contract.revenue, "contract_%s_completed" % contract.id)
			EventBus.contract_completed.emit(contract.id)
			print("[ContractManager] completed ", contract.id)
		elif contract.days_remaining <= 0:
			contract.status = "failed"
			FinanceManager.add_expense(contract.penalty, "contract_%s_penalty" % contract.id)
			EventBus.contract_failed.emit(contract.id)
			print("[ContractManager] failed ", contract.id)

func _calculate_daily_capacity() -> int:
	var productivity_sum := 0.0
	for employee in GameManager.current_company.employees:
		productivity_sum += employee.productivity
	if productivity_sum <= 0.0:
		return daily_work_capacity_base
	return int(round(daily_work_capacity_base * productivity_sum))

func _find_contract(contract_id: String) -> Contract:
	for contract in GameManager.current_company.contracts:
		if contract.id == contract_id:
			return contract
	return null
