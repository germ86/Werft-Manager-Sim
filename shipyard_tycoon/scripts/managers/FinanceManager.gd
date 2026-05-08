extends Node

var total_income: float = 0.0
var total_expenses: float = 0.0

func add_income(amount: float, reason: String = "income") -> void:
	if amount <= 0.0:
		return
	GameManager.current_company.balance += amount
	total_income += amount
	print("[FinanceManager] +", amount, " reason=", reason)
	EventBus.funds_changed.emit(GameManager.current_company.balance, amount)

func add_expense(amount: float, reason: String = "expense") -> bool:
	if amount <= 0.0:
		return true
	if GameManager.current_company.balance < amount:
		print("[FinanceManager] insufficient funds for ", reason)
		return false
	GameManager.current_company.balance -= amount
	total_expenses += amount
	print("[FinanceManager] -", amount, " reason=", reason)
	EventBus.funds_changed.emit(GameManager.current_company.balance, -amount)
	return true

func get_cashflow() -> float:
	return total_income - total_expenses
