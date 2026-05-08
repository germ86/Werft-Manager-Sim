extends Node

func _ready() -> void:
	EventBus.day_passed.connect(_on_day_passed)

func get_material(material_id: String) -> Material:
	for material in GameManager.current_company.materials:
		if material.material_id == material_id:
			return material
	return null

func purchase_material(material_id: String, amount: int) -> bool:
	var material := get_material(material_id)
	if material == null or amount <= 0:
		return false
	var price := material.current_price * float(amount)
	if not FinanceManager.add_expense(price, "material_purchase_%s" % material_id):
		return false
	material.current_stock += amount
	print("[InventoryManager] purchased", amount, material_id)
	EventBus.material_changed.emit(material_id, material.current_stock)
	return true

func consume_materials(requirements: Dictionary) -> bool:
	for material_id in requirements.keys():
		var needed: int = int(requirements[material_id])
		var material := get_material(material_id)
		if material == null or material.current_stock < needed:
			return false
	for material_id in requirements.keys():
		var needed: int = int(requirements[material_id])
		var material := get_material(material_id)
		material.current_stock -= needed
		EventBus.material_changed.emit(material_id, material.current_stock)
	print("[InventoryManager] consumed requirements ", requirements)
	return true

func _on_day_passed(_day: int) -> void:
	for material in GameManager.current_company.materials:
		var factor := randf_range(0.98, 1.02)
		material.current_price = max(1.0, material.current_price * factor)
