extends TabContainer



func _on_BottomTabs_tab_changed(tab):
	if tab == 0:
		rect_position.y = -24
		rect_size.y = 55
	elif tab == 2:
		rect_position.y = -128
		rect_size.y = 128

func _process(delta):
	if current_tab == 1:
		rect_position.y = -OS.window_size.y/1.5+48
		rect_size.y = OS.window_size.y/1.5-48

func _on_ClipboardButton_pressed():
	OS.clipboard = $Export/VBoxContainer/HBoxContainer/Command.text
