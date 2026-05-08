class_name Material
extends Resource

@export var material_id: String = ""
@export var display_name: String = ""
@export var current_stock: int = 0
@export var base_price: float = 10.0
@export var current_price: float = 10.0

func to_dict() -> Dictionary:
	return {
		"material_id": material_id,
		"display_name": display_name,
		"current_stock": current_stock,
		"base_price": base_price,
		"current_price": current_price,
	}

static func from_dict(data: Dictionary) -> Material:
	var material := Material.new()
	material.material_id = data.get("material_id", "")
	material.display_name = data.get("display_name", "")
	material.current_stock = data.get("current_stock", 0)
	material.base_price = data.get("base_price", 10.0)
	material.current_price = data.get("current_price", material.base_price)
	return material
