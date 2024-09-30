extends Node

var enemyData := {}

var enemy_data_file_path := "res://Data/StaticEnemyData.json"

func _ready() -> void:
	enemyData = load_json_file(enemy_data_file_path)


func get_max_health(enemy_name: String) -> int:
	return enemyData[enemy_name]["max_health"]

func get_money_value(enemy_name: String) -> int:
	return enemyData[enemy_name]["money_on_kill"]

func get_xp_value(enemy_name: String) -> int:
	return enemyData[enemy_name]["xp_on_kill"]


func set_max_health(enemy_name: String, new_value: int) -> void:
	enemyData[enemy_name]["max_health"] = new_value

func set_money_value(enemy_name: String, new_value: int) -> void:
	enemyData[enemy_name]["money_on_kill"] = new_value

func set_xp_value(enemy_name: String, new_value: int) -> void:
	enemyData[enemy_name]["xp_on_kill"] = new_value


func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(data_file.get_as_text())
		
		if parsed_result is Dictionary:
			return parsed_result
		else:
			push_error("Error reading file")
		
	else:
		push_error("File does not exist")
