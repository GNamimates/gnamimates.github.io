extends TabContainer



func _on_BottomTabs_tab_changed(tab):
	if tab == 0:
		rect_position.y = -44
		rect_size.y = 94
	elif tab == 2:
		rect_position.y = -140
		rect_size.y = 140

func _process(delta):
	if current_tab == 1:
		rect_position.y = -OS.window_size.y/1.5+48
		rect_size.y = OS.window_size.y/1.5-48

func _on_ClipboardButton_pressed():
	OS.clipboard = $Export/VBoxContainer/HBoxContainer/Command.text
