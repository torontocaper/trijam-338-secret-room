extends Panel

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://main.tscn")

func _on_mouse_entered() -> void:
	print_debug("mouse entered door")
	visible = true
