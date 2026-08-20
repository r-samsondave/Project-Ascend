extends Control

# Path to your actual game level or main playable scene
const GAME_SCENE_PATH = "res://scenes/level_1.tscn"

# Variable to make sure the start trigger only runs once
var has_started: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if has_started:
		return
	
	# Check if the player pressed a key, clicked a mouse button, or pressed a joypad button
	if (event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton) and event.is_pressed():
		start_game()

func start_game() -> void:
	has_started = true
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file(GAME_SCENE_PATH)
