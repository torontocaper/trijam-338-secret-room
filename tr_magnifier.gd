extends TextureRect

var dragging := false
var grab_offset_global := Vector2.ZERO
var mat: ShaderMaterial

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	mat = material as ShaderMaterial

	# Make sure the rect matches your ring PNG size (200x200)
	if texture:
		size = texture.get_size()

	# Feed viewport size (so screen sampling is correct)
	mat.set_shader_parameter("screen_size", get_viewport_rect().size)

	# Set radii to match art
	mat.set_shader_parameter("outer_radius_px", size.x * 0.5)  # 100
	mat.set_shader_parameter("frame_thickness_px", 13.0)

	z_index = 1000  # draw above other stuff

func _process(_dt: float) -> void:
	var vp_size := get_viewport_rect().size
	var center_px := global_position + size * 0.5
	mat.set_shader_parameter("lens_center_uv", center_px / vp_size)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			grab_offset_global = get_viewport().get_mouse_position() - global_position
		else:
			dragging = false
	elif dragging and event is InputEventMouseMotion:
		global_position = get_viewport().get_mouse_position() - grab_offset_global
