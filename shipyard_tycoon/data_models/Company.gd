class_name Company
extends Resource

@export var company_name: String = "Alpha Shipyard"
@export var balance: float = 10000.0
@export var reputation: int = 50
@export var employees: Array[Employee] = []
@export var contracts: Array[Contract] = []
@export var materials: Array[Material] = []
@export var loans: Array[Loan] = []
@export var kpi_history: Array[KPIReport] = []

func to_dict() -> Dictionary:
	var emp_arr: Array = []
	for e in employees:
		emp_arr.append(e.to_dict())
	var con_arr: Array = []
	for c in contracts:
		con_arr.append(c.to_dict())
	var mat_arr: Array = []
	for m in materials:
		mat_arr.append(m.to_dict())
	var loan_arr: Array = []
	for l in loans:
		loan_arr.append(l.to_dict())
	var kpi_arr: Array = []
	for k in kpi_history:
		kpi_arr.append(k.to_dict())
	return {
		"company_name": company_name,
		"balance": balance,
		"reputation": reputation,
		"employees": emp_arr,
		"contracts": con_arr,
		"materials": mat_arr,
		"loans": loan_arr,
		"kpi_history": kpi_arr,
	}

static func from_dict(data: Dictionary) -> Company:
	var company := Company.new()
	company.company_name = data.get("company_name", "Alpha Shipyard")
	company.balance = data.get("balance", 10000.0)
	company.reputation = data.get("reputation", 50)
	for e_data in data.get("employees", []):
		company.employees.append(Employee.from_dict(e_data))
	for c_data in data.get("contracts", []):
		company.contracts.append(Contract.from_dict(c_data))
	for m_data in data.get("materials", []):
		company.materials.append(Material.from_dict(m_data))
	for l_data in data.get("loans", []):
		company.loans.append(Loan.from_dict(l_data))
	for k_data in data.get("kpi_history", []):
		company.kpi_history.append(KPIReport.from_dict(k_data))
	return company
