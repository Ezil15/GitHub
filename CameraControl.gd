extends Camera2D

	
func _ready():
	set_process_input(true)
	set_fixed_process(true)
func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON):
		var Zoom = self.get_zoom()
		var MinVec = Vector2(0.1,0.1)
		if (event.button_index == BUTTON_WHEEL_UP) and Zoom > MinVec:
			Zoom.x -= 0.2
			Zoom.y -= 0.2
			self.set_zoom(Zoom)
			
	if (event.type == InputEvent.MOUSE_BUTTON):
		var Zoom = self.get_zoom()
		var MaxVec = Vector2(35,35)
		if (event.button_index == BUTTON_WHEEL_DOWN) and Zoom < MaxVec:
			Zoom.x += 0.2
			Zoom.y += 0.2
			self.set_zoom(Zoom)
func _fixed_process(delta):
	var Pos = get_pos()
	var ScreenSize = get_viewport().get_rect().size

	if get_viewport().get_mouse_pos().x < (ScreenSize.x)/8:
		Pos.x -= 10
		set_pos(Pos)
	elif get_viewport().get_mouse_pos().x > ((ScreenSize.x)/8) * 7:
		Pos.x += 10
		set_pos(Pos)
	elif get_viewport().get_mouse_pos().y < ((ScreenSize.y)/8):
		Pos.y -= 10
		set_pos(Pos)
	elif get_viewport().get_mouse_pos().y > ((ScreenSize.y)/8)*7:
		Pos.y += 10
		set_pos(Pos)
	if get_viewport().get_mouse_pos().y < ((ScreenSize.y)/8) and get_viewport().get_mouse_pos().x < (ScreenSize.x)/8:
		Pos.y -= 5
		Pos.x -= 5
		set_pos(Pos)
	elif get_viewport().get_mouse_pos().y < ((ScreenSize.y)/8) and get_viewport().get_mouse_pos().x > ((ScreenSize.x)/8) * 7:
		Pos.y -= 5
		Pos.x += 5
		set_pos(Pos)
	elif get_viewport().get_mouse_pos().y > ((ScreenSize.y)/8)*7 and get_viewport().get_mouse_pos().x < (ScreenSize.x)/8:
		Pos.y += 5
		Pos.x += 5
		set_pos(Pos)
	elif get_viewport().get_mouse_pos().y > ((ScreenSize.y)/8)*7 and get_viewport().get_mouse_pos().x > ((ScreenSize.x)/8) * 7:
		Pos.y += 5
		Pos.x -= 5
		set_pos(Pos)