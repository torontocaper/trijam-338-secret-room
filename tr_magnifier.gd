extends TextureRect

var dragging := false
var grab_offset_global := Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed == true:
			grab_offset_global = get_viewport().get_mouse_position() - global_position
			print_debug("Grab point: ", str(grab_offset_global))
			print_debug("Dragging enabled")
			dragging = true
		else:
			print_debug("Dragging disabled")
			dragging = false
	elif dragging == true and event is InputEventMouseMotion:
			global_position = get_viewport().get_mouse_position() - grab_offset_global
