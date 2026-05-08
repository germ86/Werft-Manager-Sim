extends Node

signal day_passed(current_day: int)
signal month_passed(current_month: int)
signal funds_changed(new_balance: float, difference: float)
signal kpi_updated()
signal contract_accepted(contract_id: String)
signal contract_completed(contract_id: String)
signal contract_failed(contract_id: String)
signal contract_progress_updated(contract_id: String, progress_pct: float)
signal material_changed(material_id: String, new_amount: int)
signal employee_hired(employee_id: String)
