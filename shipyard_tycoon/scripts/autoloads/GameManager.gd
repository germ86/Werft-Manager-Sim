extends Node

var current_company: Company

func _ready() -> void:
	_initialize_new_game()

func _initialize_new_game() -> void:
	current_company = Company.new()
	var steel := Material.new()
	steel.material_id = "steel"
	steel.display_name = "Steel"
	steel.current_stock = 100
	steel.base_price = 40.0
	steel.current_price = 40.0
	current_company.materials.append(steel)
	EventBus.funds_changed.emit(current_company.balance, 0.0)
